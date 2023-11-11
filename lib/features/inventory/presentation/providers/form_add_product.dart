import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_provider.dart';
import 'package:inventario_app/features/shared/shared.dart';
import 'package:inventario_app/features/inventory/domain/entities/product.dart';

// ********************************************************************** || Provider || *********************************************************************
final productFormProvider = StateNotifierProvider<ProductFormNotifier, ProductFormState>( (ref) {

  final productStateProvider = ref.watch(productProvider.notifier);

  return ProductFormNotifier( productNotifier: productStateProvider );
});

// ********************************************************************** || Notifier || **********************************************************************
class ProductFormNotifier extends StateNotifier<ProductFormState> {

  final ProductNotifier productNotifier;

  ProductFormNotifier({
    required this.productNotifier
  }):super( ProductFormState() );

  Future<Product?> onSubmit( Product product ) async {

    final productSearch = await productNotifier.addProduct(product);
    
    if( productSearch == null ){
      state.form?.reset();
    }

    state = state.copyWith( product:product );


    return productSearch;
  }

  void onSubmitEdit( Product newProduct ) async {

    await productNotifier.editProduct( state.product!.isarId, newProduct );

    state.form?.reset();
  }

  void initForm( Product product ) {

    final newForm = ProductForm().buildFormProduct(fb, product);

    state = state.copyWith( form:newForm, product:product );
  }

  void resetForm() {
    state.form?.reset();
  }
  
}

// ********************************************************************** || State || **********************************************************************
class ProductFormState {
  
  final Product? product;
  final FormGroup? form;
  
  ProductFormState({
    this.product,
    FormGroup? form,
  }) : form = form ?? ProductForm().buildForm(fb);

  ProductFormState copyWith({
    Product? product,
    FormGroup? form,
  }) {
    return ProductFormState(
      product : product ?? this.product,
      form    : form    ?? this.form,
    );
  }

}
