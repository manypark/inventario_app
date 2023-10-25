import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_app/features/inventory/infrastructure/infrastructure.dart';

import '../providers/form_add_product.dart';
import 'package:inventario_app/config/config.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormAddProductView extends StatelessWidget {

  const FormAddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FormView(),
    );
  }

}

class FormView extends ConsumerWidget {

  const FormView({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final productState = ref.watch(productFormProvider);

    final form         = productState.form;
    final sizeWidth    = MediaQuery.sizeOf(context).width;
    final unit         = ['PZ', 'CJA'];

    void showSnackBar( BuildContext context, String message ) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content      : Text(message),
          showCloseIcon: true,
          duration     : const Duration( seconds: 3 ),
        )
      );
    }

    Color getColor( Set<MaterialState> states ) {
      return states.contains( MaterialState.disabled ) ? Colors.grey.shade800 : colorSeed;
    }

    return SingleChildScrollView(
      child: ReactiveForm(
        formGroup : form!,
        child     : Container(
          padding : const EdgeInsets.symmetric( horizontal: 20, vertical: 50 ),
          width   : sizeWidth * 0.5,
          child   : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children          : [
        
              // Nombre producto
              ReactiveTextField(
                formControlName   : 'name',
                validationMessages: {
                  'required': (error) => 'El nombre no puede ser vacío'
                },
                style : const TextStyle( fontSize: 24 ),
                decoration: const InputDecoration(
                  labelText : 'Nombre del producto',
                  hintText  : 'Producto',
                  border    : OutlineInputBorder(
                    borderRadius: BorderRadius.all( Radius.circular( 10 ) ),
                  )
                ),
              ),
      
              const SizedBox( height: 40 ),
      
              // Stock, unidad
              Row(
                children: [
      
                  Expanded(
                    flex: 1,
                    child: ReactiveTextField(
                      formControlName: 'stock',
                      validationMessages: {
                        'required': (error) => 'El stock no puede ser vacío'
                      },
                      style          : const TextStyle( fontSize: 24 ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      keyboardType: TextInputType.number,
                      decoration  : const InputDecoration(
                        labelText : 'Stock',
                        hintText  : 'Stock',
                        border    : OutlineInputBorder(
                          borderRadius: BorderRadius.all( Radius.circular( 10 ) ),
                        )
                      ),
                    ),
                  ),
      
                  const SizedBox( width: 25 ),
      
                  Expanded(
                    flex  : 1,
                    child: ReactiveDropdownField<String>(
                      formControlName   : 'unit',
                      validationMessages: {
                        'required': (error) => 'La unidad no puede ser vacío'
                      },
                      hint          : const Text('Unidad', style: TextStyle(fontSize: 16 ),),
                      enableFeedback: true,
                      borderRadius  : BorderRadius.circular(10),
                      decoration    : const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all( Radius.circular( 10 ) ),
                        )
                      ),
                      icon          : const Icon( Icons.keyboard_arrow_down_rounded, color: Color(0xffB0B7D9) , size: 34, ),
                      dropdownColor : Colors.grey.shade200,
                      elevation     : 2,
                      isExpanded    : true,
                      items         : unit.map<DropdownMenuItem<String>>(( String value ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle( color: Colors.black, fontSize: 20 ),),
                        );
                      }).toList(),
                    ),
                  )
      
                ],
              ),
      
              const SizedBox( height: 40 ),
      
              // Precio mayoreo, precio venta
              Row(
                children: [
      
                  Expanded(
                    flex: 1,
                    child: ReactiveTextField(
                      formControlName: 'priceUnit',
                      validationMessages: {
                        'required': (error) => 'El precio de mayoreo no puede ser vacío',
                      },
                      style          : const TextStyle( fontSize: 24 ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        labelText : 'Precio Mayoreo',
                        hintText  : 'Precio',
                        border    : OutlineInputBorder(
                          borderRadius: BorderRadius.all( Radius.circular( 10 ) ),
                        )
                      ),
                    ),
                  ),
      
                  const SizedBox( width: 25 ),
      
                  Expanded(
                    flex: 1,
                    child: ReactiveTextField(
                      formControlName: 'priceSale',
                      validationMessages: {
                        'required': (error) => 'El precio de venta no puede ser vacío'
                      },
                      style          : const TextStyle( fontSize: 24 ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        labelText : 'Precio venta',
                        hintText  : 'Precio',
                        border    : OutlineInputBorder(
                          borderRadius: BorderRadius.all( Radius.circular( 10 ) ),
                        )
                      ),
                    ),
                  ),
                ],
              ),
      
              const SizedBox( height: 60 ),
      
              // button guardar
              ReactiveFormConsumer(
                builder: (context, formGroup, _) {
                  return TextButton(
                    style: ButtonStyle(
                      backgroundColor : MaterialStateProperty.resolveWith( getColor ),
                      padding         : const MaterialStatePropertyAll( EdgeInsets.all(12)),
                      minimumSize     : MaterialStatePropertyAll( Size((sizeWidth * 0.3), 70) ),
                    ),
                    onPressed: !form.valid ? null : () {

                      final productFormMapper = ProductMapper.jsonToEntity(form.value);

                      ref.read(productFormProvider.notifier).onSubmit(productFormMapper);

                      showSnackBar( context, 'Producto nuevo agregado' );
                    },
                    child    : const Text('Guardar', style: TextStyle( color: Colors.white, fontSize: 24 ),),
                  );
                },
              ),
              // button guardar
      
            ],
          ),
        ),
      ),
    );

  }

}
