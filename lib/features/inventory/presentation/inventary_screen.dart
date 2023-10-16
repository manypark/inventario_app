import 'package:flutter/material.dart';
import 'package:inventario_app/config/config.dart';

import 'views/data_table_view.dart';
import 'views/form_add_product_view.dart';

class InventaryScreen extends StatelessWidget {
  
  const InventaryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final titleStyle  = Theme.of(context).textTheme.titleLarge;
    final titleMedium = Theme.of(context).textTheme.titleMedium;

    return DefaultTabController(
      animationDuration: const Duration( milliseconds: 300 ),
      initialIndex: 0,
      length: 2, 
      child : Scaffold(
        appBar: AppBar(
          centerTitle     : false,
          backgroundColor : colorSeed,
          title : Text('Inventario App', style: titleStyle ),
          bottom: TabBar(
            enableFeedback  : true,
            indicatorColor  : Colors.pinkAccent,
            indicatorWeight : 5,
            tabs: [
              Tab(
                icon: const Icon(Icons.list_alt_outlined, color: Colors.white,), 
                child: Text('Inventario', style: titleMedium )
              ),
              Tab(
                icon: const Icon(Icons.inventory_2_outlined, color: Colors.white), 
                child: Text('Alta producto', style: titleMedium )
              ),
            ]
          ),
        ),
        body: const TabBarView(
          children: [
            MyPaginatedDataTable(),
            FormAddProductView(),
          ],
        ),
      )
    );
  }

}
