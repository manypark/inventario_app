import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventario_app/config/theme/app_theme.dart';
import 'package:inventario_app/features/inventory/inventary.dart';

void main() {
  
  runApp(
    const ProviderScope( child: MainApp() )
  );
  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home  : const InventaryScreen(),
      theme : AppTheme().getTheme(),
    );
  }
  
}
