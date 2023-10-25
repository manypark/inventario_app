import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventario_app/features/inventory/domain/domain.dart';
import 'package:inventario_app/features/inventory/infrastructure/infrastructure.dart';

// ********************************************************************** || Provider || *********************************************************************
final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(localDbRepository: LocalDbRepositoryImpl() );
});

// ********************************************************************** || Notifier || **********************************************************************
class ProductNotifier extends StateNotifier<ProductState> {

  final LocalDbRepository localDbRepository;

  ProductNotifier({ required this.localDbRepository }):super( ProductState() ) {
    loadProducts();
  }

  Future<void> addProduct( Product product ) async {

    await localDbRepository.addProduct(product);

    loadProducts();
  }

  Future<void> loadProducts() async {

    final productsDb = await localDbRepository.getProducts();

    state = state.copyWith( products:productsDb );
  }


  Future<void> searchProduct( String productName ) async {

    // final searchProduct = state.products?.where((p) => p.name.toLowerCase().contains( product.toLowerCase() ) ).toList();
    final searchProduct = await localDbRepository.getProductByName(productName);

    state = state.copyWith( products: searchProduct );
  }

  Future<void> deleteProduct( int idProduct ) async {

    await localDbRepository.deleteProduct(idProduct);

    loadProducts();
  }

  Future<void> editProduct( int idProduct, Product oldProduct ) async {

    await localDbRepository.editProduct(idProduct, oldProduct);

    loadProducts();
  }
}
// ********************************************************************** || State || ************************************************************************
class ProductState {

  final Product? editProduct;
  final List<Product>? products;

  ProductState({
    this.editProduct,
    List<Product>? products,
  }): products = products ?? [];

  ProductState copyWith({
    Product? editProduct,
    List<Product>? products,
  }) {
    return ProductState(
      editProduct : editProduct  ?? this.editProduct,
      products: products ?? this.products,
    );
  }

}
