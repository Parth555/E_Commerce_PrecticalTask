import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

// ignore_for_file: public_member_api_docs

@Entity()
class CartItem {
  @Id()
  int id;

  int? itemId;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  double? rate;
  int? rateCount;
  int? itemCount;
  int? selectedColor;
  int? selectedSize;
  int? orderId;
  int? isConformed;

  /// Note: Stored in milliseconds without time zone info.
  DateTime date;

  CartItem({
    this.id = 0,
    this.itemId,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rate,
    this.rateCount,
    this.itemCount,
    this.selectedColor,
    this.selectedSize,
    this.orderId = 0,
    this.isConformed = 0,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  String get dateFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(date);
}
