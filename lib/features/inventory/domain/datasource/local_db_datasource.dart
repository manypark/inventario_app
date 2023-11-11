import '../entities/product.dart';

abstract class LocalDbDatasource {

  Future<void> addProduct( Product product );
  Future<List<Product>> getProducts();
  Future<dynamic> getProductByName( String nameProduct );
  Future<Product?> getProductByNameExac( String nameProduct );
  Future<void> editProduct(  int idProduct, Product product );
  Future<void> deleteProduct( int idProduct );
  Future<void> createBackUp();
  
}