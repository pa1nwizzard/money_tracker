import 'package:flutter/material.dart';
import 'package:money_tracker/data/operation.dart';

class OperationProvider extends ChangeNotifier {
  List<Operation> _ops = [];

  List<Operation> get ops => _ops;

  void add(Operation op) {
    //_ops.add(op);
    _ops.insert(0, op);
    notifyListeners();
  }

  void deleteOp(int index) {
    _ops.removeAt(index);
    deleteOperation(index);
    notifyListeners();
  }

  Future<void> initDB() async {
    _ops = await getOperations();
    notifyListeners();    
  }
}