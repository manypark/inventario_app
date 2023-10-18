import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart'; 

import 'package:inventario_app/features/inventory/domain/domain.dart';

class IsarDatasource extends LocalDbDatasource {

  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {

    final dir = await getApplicationDocumentsDirectory();

    if( Isar.instanceNames.isEmpty ) {
      return await Isar.open( 
        [ ProductSchema ], 
        directory: dir.path,
        inspector: true 
      );
    }

    return Future.value( Isar.getInstance() );
  }

  @override
  Future<void> addProduct( Product product ) async {
    
    try {

      final isar = await db;

      await isar.writeTxn(() async {
        await isar.products.put(product);
      });

      
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(int idProduct) async {
    
    try {
      final isar = await db;

      await isar.writeTxn(() async {
        await isar.products.delete(idProduct);
      });

    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> editProduct(int idProduct, Product product) async {
    
    try {

      final isar = await db;

      await isar.writeTxn(() async {
        await isar.products.put(product);
      });
      
    } catch (e) {
      throw Exception(e.toString());
    }

  }

  @override
  Future<List<Product>> getProducts() async {
      final isar = await db;
      return await isar.products.where().findAll();
  }

  @override
  Future<dynamic> getProductByName( String nameProduct ) async {
    final isar = await db;
    return await isar.products.filter().nameContains(nameProduct).findAll();
  }
  
}