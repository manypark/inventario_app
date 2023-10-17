import 'package:reactive_forms/reactive_forms.dart';

class ProductForm {

  FormGroup buildForm( FormBuilder formBuilder ) {
    
    return formBuilder.group({
      'name'      : ['', Validators.required ],
      'stock'     : ['', Validators.required ],
      'unit'      : ['', Validators.required ],
      'priceUnit' : ['', Validators.required ],
      'priceSale' : ['', Validators.required ]
    });
  }

}
