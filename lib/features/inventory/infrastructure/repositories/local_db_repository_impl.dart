import 'package:inventario_app/features/inventory/domain/domain.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {

  final LocalDbDatasource datasource;
  LocalDbRepositoryImpl(this.datasource);

  @override
  Future<void> addProduct(Product product) {
    return datasource.addProduct(product);
  }

  @override
  Future<void> deleteProduct(int idProduct) {
    return datasource.deleteProduct(idProduct);
  }

  @override
  Future<void> editProduct(int idProduct, Product product) {
    return datasource.editProduct(idProduct, product);
  }

  @override
  Future getProductByName( String nameProduct) {
    return datasource.getProductByName(nameProduct);
  }

  @override
  Future<List<Product>> getProducts() {
    return datasource.getProducts();
  }
  
}