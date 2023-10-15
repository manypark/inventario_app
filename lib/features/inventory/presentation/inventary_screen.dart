import 'package:flutter/material.dart';

class InventaryScreen extends StatelessWidget {
  
  const InventaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InventaryView(),
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