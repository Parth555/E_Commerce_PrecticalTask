import 'package:e_commerce/models/add_to_cart_request.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../objectbox.g.dart';
import '../utils/debug.dart';
import 'cart_model.dart';
import 'order_model.dart'; // created by `dart run build_runner build`

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class ObjectBox {
  /// The Store of this app.
  late final Store _store;

  /// A Box of notes.
  late final Box<CartItem> _cartBox;
  late final Box<OrderModelItem> _orderBox;

  ObjectBox._create(this._store) {
    _cartBox = Box<CartItem>(_store);
    _orderBox = Box<OrderModelItem>(_store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(
        directory:
            p.join((await getApplicationDocumentsDirectory()).path, "obx-demo"),
        macosApplicationGroup: "objectbox.demo");
    return ObjectBox._create(store);
  }

 List<CartItem> getCartItems()  {
    final builder =
        _cartBox.query(CartItem_.isConformed.equals(0)).order(CartItem_.date, flags: Order.descending);
    return builder.build().find();
  }

  updateCartItems(int orderId)  {
    final builder =
        _cartBox.query(CartItem_.orderId.equals(orderId)).order(CartItem_.date, flags: Order.descending);
    List<CartItem> itemList =  builder.build().find();
    for(var item in itemList){
      Debug.printLog('itemList :${item.id}');
     var cartItem = _cartBox.get(item.id)!;      // Read
     cartItem.isConformed = 1;
     _cartBox.put(cartItem);            // Update
    }
  }

  int getItemCount() {
    final builder =  _cartBox.query(CartItem_.isConformed.equals(0)).order(CartItem_.date, flags: Order.descending);
    return builder.build().find().length;
  }

  int getOrderCount() {
    final builder =  _orderBox.count();
    return builder;
  }

  /// Add a note.
  ///
  /// To avoid frame drops, run ObjectBox operations that take longer than a
  /// few milliseconds, e.g. putting many objects, asynchronously.
  /// For this example only a single object is put which would also be fine if
  /// done using [Box.put].
  Future<void> addItemToCart(Products product, int itemCount,
          int selectedColour, int selectedSize,int orderId) =>
      _cartBox.putAsync(CartItem(
          itemId:product.id,
          title: product.title,
          price: product.price,
          description: product.description,
          category: product.category,
          image:product.image,
          rate: product.rating!.rate,
          rateCount: product.rating!.count,
          itemCount: itemCount,
          selectedColor: selectedColour,
          selectedSize: selectedSize,
        orderId: orderId
      ));


Future<void> addOrder(double totalPrice) =>
      _orderBox.putAsync(OrderModelItem(isConformed: 1,totalPrice: totalPrice));


  Future<void> removeCartItem(int id) => _cartBox.removeAsync(id);
}
