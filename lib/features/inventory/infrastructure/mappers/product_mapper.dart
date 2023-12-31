
import 'package:inventario_app/features/inventory/domain/entities/product.dart';

class ProductMapper {

  static Product jsonToEntity( Map<String, dynamic> json ) => Product(
    name      : json['name'], 
    stock     : int.parse(json['stock']), 
    unit      : json['unit'], 
    priceUnit : int.parse(json['priceUnit']),
    priceSale : int.parse(json['priceSale'])
  );
  
}