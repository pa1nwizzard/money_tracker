import 'package:money_tracker/main.dart';
import 'package:sqflite/sqflite.dart';

class Operation {
  final int id;
  final String type;
  final String category;
  final double count;
  final String date;

  const Operation({
    required this.id,
    required this.type,
    required this.category,
    required this.count,
    required this.date
  });

  Map<String, Object?> toMap() {
    return {'id': id, 'type': type, 'category': category, 'count': count, 'date' : date};
  }

  @override
  String toString() {
    return 'Operation{id: $id, type: $type, category: $category, count $count, date $date}';
  }
}

Future<void> insertOperation(Operation op) async {
  final db = await database;

  await db.insert(
    'operations',
    op.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Operation>> getOperations() async {
  final db = await database;
  
  final List<Map<String, Object?>> opMaps = await db.query('operations');

  return [
    for (final {
      'id': id as int,
      'type': type as String,
      'category': category as String,
      'count': count as double,
      'date': date as String }
      in opMaps) 
        Operation(id: id, type: type, category: category, count: count, date: date)
  ];
}

Future<List<Map<String, Object?>>> getOperationsToMaps() async {
  final db = await database;
  
  final List<Map<String, Object?>> opMaps = await db.query('operations');

  return opMaps;
}

Future<void> deleteOperation(int id) async {
  final db = await database;  
  await db.delete(
    'operations',
    where: 'id = ?',
    whereArgs: [id]
  );
  List<Operation> ops = await getOperations();
  await db.delete('operations');
  for (int i = 0; i < ops.length; i++) {
    insertOperation(Operation(id: i, type: ops[i].type, category: ops[i].category, count: ops[i].count, date: ops[i].date));
  }
}