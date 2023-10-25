import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventario_app/features/shared/shared.dart';
import 'package:inventario_app/features/inventory/domain/domain.dart';
import 'package:inventario_app/features/inventory/presentation/providers/providers.dart';


class MyPaginatedDataTable extends ConsumerStatefulWidget {

  const MyPaginatedDataTable({super.key});

  @override
  MyPaginatedDataTableState createState() => MyPaginatedDataTableState();
}

class MyPaginatedDataTableState extends ConsumerState<MyPaginatedDataTable> {

  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  TextEditingController controller = TextEditingController();

  void sort<T>(Comparable<T> Function(Map<dynamic, dynamic> d) getField, int columnIndex, bool ascending, List<Product> dataList) {
    dataList.sort((a, b) {
      final Comparable<T> aValue = getField(a as Map);
      final Comparable<T> bValue = getField(b as Map);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending   = ascending;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final sizeWidth = MediaQuery.sizeOf(context).width;
    final productStateProvider = ref.watch(productProvider).products;

    if( productStateProvider == null ) {
      return const Scaffold( body: Center( child: CircularProgressIndicator() ) );
    }

    List<Product> dataList = productStateProvider;

    return Scaffold(
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          header       : Row(
            children: [

              Expanded(
                flex: 3,
                child: TextFormField(
                  controller        : controller,
                  onEditingComplete : () async {

                    if( controller.text == '' ) {
                      ref.read(productProvider.notifier).loadProducts();
                      return;
                    }

                    await ref.read(productProvider.notifier).searchProduct( controller.text );
                  },
                  decoration: const InputDecoration(
                    hintText: 'Buscar producto',
                  ),
                ),
              ),

              // Expanded(
              //   flex: 1,
              //   child: TextButton(
              //     onPressed: () {
              //       ref.read(productProvider.notifier).loadProducts();
              //     }, 
              //     style: ButtonStyle(
              //         backgroundColor : const MaterialStatePropertyAll( Colors.amber ),
              //         padding         : const MaterialStatePropertyAll( EdgeInsets.all(12)),
              //         minimumSize     : MaterialStatePropertyAll( Size((sizeWidth * 0.2), 70) ),
              //     ),
              //     child: const Text('Cargar productos', style: TextStyle( color: Colors.white, fontSize: 24 ),),
              //   ),
              // ),

            ],
          ),
          columnSpacing: (sizeWidth * 0.1),
          showFirstLastButtons: true,
          rowsPerPage         : _rowsPerPage,
          availableRowsPerPage: const [10, 20, 30],
          onRowsPerPageChanged: (int? value) {
            setState(() { 
              _rowsPerPage = value!; 
            });
          },
          sortColumnIndex : _sortColumnIndex,
          sortAscending   : _sortAscending,
          columns         : [
            DataColumn(
              label : const Text('Nombre Producto'),
              onSort: (columnIndex, ascending) {
                sort<String>((d) => d['name']!, columnIndex, ascending, dataList);
              },
            ),
            DataColumn(
              label : const Text('Unidad'),
              onSort: (columnIndex, ascending) {
                sort<String>((d) => d['unit']!, columnIndex, ascending, dataList);
              }
            ),
            DataColumn(
              label   : const Text('Stock'),
              tooltip : 'Numero de piezas de tu producto',
              onSort  : (columnIndex, ascending) {
                sort<String>((d) => d['stock']!, columnIndex, ascending, dataList);
              }
            ),
            DataColumn(
              label : const Text('Precio Unitario'),
              onSort: (columnIndex, ascending) {
                sort<String>((d) => d['priceUnit'].substring(1), columnIndex, ascending, dataList);
              }
            ),
            DataColumn(
              label : const Text('Precio Venta'),
              onSort: (columnIndex, ascending) {
                sort<String>((d) => d['priceSale'].substring(1), columnIndex, ascending, dataList);
              }
            ),
            const DataColumn(
              label : Text('Actions'),
            ),
          ],
          source          : MyDataTableSource(
            dataList, 
            ref.read(productProvider.notifier).deleteProduct,
            ref.read(productFormProvider.notifier).initForm,
            context
          ),
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {

  final List<Product> dataList;
  final Future<void> Function(int) deleteProduct;
  final Function(Product) initFormProduct;
  final BuildContext context;

  MyDataTableSource(this.dataList, this.deleteProduct, this.initFormProduct, this.context);

  void openDialogForm(BuildContext context ) {
    showDialog(
      context           : context,
      barrierDismissible: true,
      useSafeArea       : true,
      builder           : (context) {
        return AlertDialog(
          title  : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Editar producto'),
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon( Icons.cancel, size: 40,) )
            ],
          ),
          content: const FormViewAddProduct(),
        );
      },
    );
  }

  void openDialog( BuildContext context, Product product ) {

    showDialog(
      context           : context,
      barrierDismissible: false,
      builder           : (context) => AlertDialog(
        title   : const Text('¿ Estas seguro ?'),
        content : Text('Deseas eliminar este producto: ${product.name}'),
        actions : [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar')
          ),

          FilledButton(
            onPressed: () {
              deleteProduct(product.isarId);
              Navigator.pop(context);
            }, 
            child: const Text('Aceptar'),
          ),
        ],
      ) );
  }

  @override
  DataRow getRow(int index) {

    final data = dataList[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text( data.name ) ),
        DataCell( Text( data.unit ) ),
        DataCell( Text( data.stock.toString() ) ),
        DataCell( Text( '\$ ${data.priceUnit.toString()}' ) ),
        DataCell( Text( '\$ ${data.priceSale.toString()}' ) ),
        DataCell(
          Row(
            children: [
              IconButton(
                hoverColor  : Colors.transparent,
                splashColor : Colors.transparent,
                color       : Colors.green,
                icon        : const Icon(Icons.edit),
                onPressed   : () {
                  initFormProduct( data );
                  openDialogForm(context);
                },
              ),
              IconButton(
                hoverColor  : Colors.transparent,
                splashColor : Colors.transparent,
                color       : Colors.red,
                icon        : const Icon(Icons.delete_forever),
                onPressed   : () async {
                  openDialog( context, data );
                },
              ),
            ],
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataList.length;

  @override
  int get selectedRowCount => 0;
}