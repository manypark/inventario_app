import 'package:flutter/material.dart';
import 'package:inventario_app/config/config.dart';

class FormAddProductView extends StatelessWidget {

  const FormAddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FormView(),
    );
  }

}

class FormView extends StatelessWidget {

  const FormView({super.key});

  @override
  Widget build(BuildContext context) {

  final sizeWidth = MediaQuery.sizeOf(context).width;
  final unit = ['PZ', 'CJA'];

  Color getColor( Set<MaterialState> states ) {
    return states.contains( MaterialState.disabled ) ? Colors.grey.shade800 : colorSeed;
  }

    return SingleChildScrollView(
      child: Container(
        padding : const EdgeInsets.symmetric( horizontal: 20, vertical: 50 ),
        width   : sizeWidth * 0.5,
        child   : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children          : [
      
            // Nombre producto
            TextFormField(
              decoration: const InputDecoration(
                labelText : 'Nombre del producto',
                hintText  : 'Producto...',
                border    : OutlineInputBorder(
                  borderRadius: BorderRadius.all( Radius.circular( 10 ) ),
                )
              ),
            ),

            const SizedBox( height: 20 ),

            // Stock, unidad
            Row(
              children: [

                Expanded(
                  flex: 1,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
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
                  child: DropdownButton<String>(
                    enableFeedback: true,
                    borderRadius  : BorderRadius.circular(10),
                    value         : unit[0],
                    icon          : const Icon( Icons.keyboard_arrow_down_rounded, color: Color(0xffB0B7D9) , size: 34, ),
                    dropdownColor : Colors.grey.shade200,
                    elevation     : 2,
                    isExpanded    : true,
                    underline     : Container( height: 0, color : Colors.grey ),
                    onChanged     : (value) {
                
                    },
                    items : unit.map<DropdownMenuItem<String>>(( String value ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle( color: Colors.black ),),
                      );
                    }).toList(),
                  ),
                )

              ],
            ),

            const SizedBox( height: 20 ),

            //Precio unitario, precio venta
            Row(
              children: [

                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText : 'Precio unitario',
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
                  child: TextFormField(
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

            TextButton(
              style: ButtonStyle(
                backgroundColor : MaterialStateProperty.resolveWith( getColor ),
                padding         : const MaterialStatePropertyAll( EdgeInsets.all(12)),
                minimumSize     : MaterialStatePropertyAll( Size((sizeWidth * 0.3), 70) ),
              ),
              onPressed: null,
              child    : const Text('Guardar', style: TextStyle( color: Colors.white, fontSize: 24 ),),
            ),

          ],
        ),
      ),
    );
  }
}
