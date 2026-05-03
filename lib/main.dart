import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:money_tracker/providers/operation_provider.dart';
import 'package:money_tracker/views/widget_tree.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// -- function to initialize the database --
Future<Database> initDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'operations_db.db',
  );
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE operations(id INTEGER PRIMARY KEY, type TEXT, category TEXT, count DOUBLE, date TEXT)'
      );     
    },
  );
}

final Future<Database> database = initDatabase();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => OperationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        
      ),
      home: WidgetTree(),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}
