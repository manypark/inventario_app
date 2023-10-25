import 'package:isar/isar.dart';
part 'product.g.dart';

@collection
class Product {

  Id isarId = Isar.autoIncrement;

  String name;
  int stock;
  String unit;
  double priceUnit;
  double priceSale;
  
  Product({
    required this.name,
    required this.stock,
    required this.unit,
    required this.priceUnit,
    required this.priceSale,
  });
  
  @override
  String toString() {
    return 'name: $name, stock: $stock, unit: $unit, priceUnit: $priceUnit, priceSale: $priceSale';
  }
}
