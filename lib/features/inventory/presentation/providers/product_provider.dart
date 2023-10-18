import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventario_app/features/inventory/domain/domain.dart';
import 'package:inventario_app/features/inventory/infrastructure/infrastructure.dart';
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

    final List<Product> newProducts = [];
    final List<Map<String, dynamic>> staticProducts = [
    {
      "id":1,
      "name" : "Nutri leche",
      "stock" : "100",
      "unit" : "PZ",
      "priceUnit" : "18",
      "priceSale" : "23",
    },
    {
      "id":2,
      "name" : "Santa clara leche",
      "stock" : "80",
      "unit" : "PZ",
      "priceUnit" : "23",
      "priceSale" : "27",
    },
    {
      "id":3,
      "name" : "Yurecuaro",
      "stock" : "70",
      "unit" : "PZ",
      "priceUnit" : "10",
      "priceSale" : "12",
    },
  ];

    newProducts.addAll( staticProducts.map( (p) => ProductMapper.jsonToEntity(p) ).toList());

    state = state.copyWith( products:newProducts );

  }

  Future<void> searchProduct( String product ) async {

    final searchProduct = state.products?.where((p) => p.name.toLowerCase().contains( product.toLowerCase() ) ).toList();

    state = state.copyWith( products: searchProduct );
  }

  Future<void> deleteProduct( String nameProduct ) async {

    final newFilterListProduct = state.products?.where((p) => p.name.toLowerCase() != nameProduct.toLowerCase() ).toList();

    state = state.copyWith( products: newFilterListProduct );
  }

  Future<void> editProduct( Product productEdit, Product oldProduct ) async {

    final productToEdit = state.products?.where((p) => p.name.toLowerCase() == oldProduct.name.toLowerCase() ).first;

    deleteProduct(productToEdit!.name);

    state.products?.add(productEdit);
    final newListProduct = state.products;

    state = state.copyWith( products: newListProduct );
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
