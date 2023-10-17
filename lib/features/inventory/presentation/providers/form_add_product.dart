import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_app/features/shared/shared.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:inventario_app/features/inventory/domain/entities/product.dart';

final productProvider = StateNotifierProvider<ProductFormNotifier, ProductFormState>( (ref) {
  return ProductFormNotifier();
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {

  ProductFormNotifier():super( ProductFormState() );

  onSubmit( Product product ) {

    state = state.copyWith( product:product );

    print('state: $product');

  }
  
}

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
