import 'package:flutter/material.dart';

class MyPaginatedDataTable extends StatefulWidget {

  const MyPaginatedDataTable({super.key});

  @override
  MyPaginatedDataTableState createState() => MyPaginatedDataTableState();
}

class MyPaginatedDataTableState extends State<MyPaginatedDataTable> {

  int _rowsPerPage = 5;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  final List<Map<String, String>> _dataList = [
    {
      'nombre_producto': 'Producto 1',
      'unidad': 'PZ',
      'stock': '10',
      'precio_unitario': '\$10',
      'precio_venta': '\$15',
    },
    {
      'nombre_producto': 'Producto 2',
      'unidad': 'CJA',
      'stock': '5',
      'precio_unitario': '\$12',
      'precio_venta': '\$18',
    },
    {
      'nombre_producto': 'Producto 3',
      'unidad': 'PZ',
      'stock': '15',
      'precio_unitario': '\$10',
      'precio_venta': '\$13',
    },
    // Agrega más datos aquí
  ];

  void sort<T>(Comparable<T> Function(Map<dynamic, dynamic> d) getField, int columnIndex, bool ascending) {
    _dataList.sort((a, b) {
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
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

    return Scaffold(
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          columnSpacing: (sizeWidth * 0.1),
          showFirstLastButtons: true,
          rowsPerPage         : _rowsPerPage,
          availableRowsPerPage: const [5, 10, 20, 30],
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
                sort<String>((d) => d['nombre_producto']!, columnIndex, ascending);
              },
            ),
            DataColumn(
              label : const Text('Unidad'),
              onSort: (columnIndex, ascending) {
                sort<String>((d) => d['unidad']!, columnIndex, ascending);
              }
            ),
            DataColumn(
              label   : const Text('Stock'),
              tooltip : 'Numero de piezas de tu producto',
              onSort  : (columnIndex, ascending) {
                sort<String>((d) => d['stock']!, columnIndex, ascending);
              }
            ),
            DataColumn(
              label : const Text('Precio Unitario'),
              onSort: (columnIndex, ascending) {
                sort<String>((d) => d['precio_unitario'].substring(1), columnIndex, ascending);
              }
            ),
            DataColumn(
              label : const Text('Precio Venta'),
              onSort: (columnIndex, ascending) {
                sort<String>((d) => d['precio_venta'].substring(1), columnIndex, ascending);
              }
            ),
            const DataColumn(
              label : Text('Actions'),
            ),
          ],
          source: MyDataTableSource(_dataList),
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {

  final List<Map<String, String>> _dataList;

  MyDataTableSource(this._dataList);

  @override
  DataRow getRow(int index) {

    final data = _dataList[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text(data['nombre_producto'] ?? 'nombre_producto' ) ),
        DataCell( Text(data['unidad'] ?? 'unidad' ) ),
        DataCell( Text(data['stock'] ?? 'stock' ) ),
        DataCell( Text(data['precio_unitario'] ?? 'precio_unitario' ) ),
        DataCell( Text(data['precio_venta'] ?? 'precio_venta' ) ),
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
  int get rowCount => _dataList.length;

  @override
  int get selectedRowCount => 0;
}