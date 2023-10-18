import 'package:inventario_app/features/inventory/domain/domain.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProductForm {

  FormGroup buildForm( FormBuilder formBuilder) {
    
    return formBuilder.group({
      'name'      : ['', Validators.required ],
      'stock'     : ['', Validators.required ],
      'unit'      : ['', Validators.required ],
      'priceUnit' : ['', Validators.required ],
      'priceSale' : ['', Validators.required ]
    });
  }

  FormGroup buildFormProduct( FormBuilder formBuilder, Product product ) {
    
    return formBuilder.group({
      'name'      : [ product.name,     Validators.required ],
      'stock'     : [ product.stock.toString(),    Validators.required ],
      'unit'      : [ product.unit,     Validators.required ],
      'priceUnit' : [ product.priceUnit.toString(),Validators.required ],
      'priceSale' : [ product.priceSale.toString() ,Validators.required ]
    });
  }

}
