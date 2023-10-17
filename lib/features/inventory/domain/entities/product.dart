
class Product {

  String id;
  String name;
  int stock;
  String unit;
  int priceUnit;
  int priceSale;
  
  Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.unit,
    required this.priceUnit,
    required this.priceSale,
  });
  

  @override
  String toString() {
    return 'id: $id, name: $name, stock: $stock, unit: $unit, priceUnit: $priceUnit, priceSale: $priceSale';
  }
}
