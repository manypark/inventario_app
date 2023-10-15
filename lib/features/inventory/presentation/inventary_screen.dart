import 'package:flutter/material.dart';

class InventaryScreen extends StatelessWidget {
  
  const InventaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child : Scaffold(
        appBar: AppBar(
          title : const Text('Inventario App'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ]
          ),
        ),
        body: const TabBarView(
          children: [
            InventaryView(),
            Icon(Icons.directions_transit),
          ],
        ),
      )
    );
  }

}

class InventaryView extends StatelessWidget {

  const InventaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Inventary view'),
    );
  }
}