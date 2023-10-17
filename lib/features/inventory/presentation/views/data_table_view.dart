import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_app/features/inventory/domain/domain.dart';

import '../providers/product_provider.dart';

class MyPaginatedDataTable extends ConsumerStatefulWidget {

  const MyPaginatedDataTable({super.key});

  @override
  MyPaginatedDataTableState createState() => MyPaginatedDataTableState();
}

class MyPaginatedDataTableState extends ConsumerState<MyPaginatedDataTable> {

  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  
  @override
  void initState() {
    super.initState();
    ref.read(productProvider.notifier).loadProducts();
  }

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
  Widget build(BuildContext context) {

    final sizeWidth = MediaQuery.sizeOf(context).width;
    final productStateProvider = ref.watch(productProvider).products;

    if( productStateProvider == null ) {
      return const Scaffold( body: Center( child: CircularProgressIndicator() ) );
    }

    final List<Product> dataList = productStateProvider;

    return Scaffold(
      body: SingleChildScrollView(
        child: PaginatedDataTable(
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
          source: MyDataTableSource(dataList),
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {

  final List<Product> dataList;

  MyDataTableSource(this.dataList);

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
                onPressed   : () {},
              ),
              IconButton(
                hoverColor  : Colors.transparent,
                splashColor : Colors.transparent,
                color       : Colors.red,
                icon        : const Icon(Icons.delete_forever),
                onPressed   : () {},
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