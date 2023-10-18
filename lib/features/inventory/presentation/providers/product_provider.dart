import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventario_app/features/inventory/domain/domain.dart';
// import 'package:inventario_app/features/inventory/infrastructure/infrastructure.dart';

// ********************************************************************** || Provider || *********************************************************************
final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  // return ProductNotifier(localDbRepository: LocalDbRepositoryImpl() );
  return ProductNotifier();
});

// ********************************************************************** || Notifier || **********************************************************************
class ProductNotifier extends StateNotifier<ProductState> {

  // final LocalDbRepository localDbRepository;

  // ProductNotifier({ required this.localDbRepository }):super( ProductState() );
  ProductNotifier():super( ProductState() );

  Future<void> addProduct( Product product ) async {

    // await localDbRepository.addProduct(product);

    state.products?.add(product);
    final newProduct = state.products;

    state = state.copyWith( products:newProduct );
  }

  Future<void> loadProducts() async {

    // final products = await localDbRepository.getProducts();

    state = state.copyWith( products:[] );
  }
  
}
// ********************************************************************** || State || ************************************************************************
class ProductState {

  final Product? editProduct;
  List<Product>? products;

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
