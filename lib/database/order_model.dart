import 'package:e_commerce/database/cart_model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';

@Entity()
class OrderModelItem {
  @Id()
  int id;
  int isConformed;
  String address;
  String paymentType;
  double totalPrice;
  /// Note: Stored in milliseconds without time zone info.
  DateTime date;

  OrderModelItem({
    this.id = 0,
    this.totalPrice = 0,
    this.address = '',
    this.paymentType = '',
    required this.isConformed,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  String get dateFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(date);
}
