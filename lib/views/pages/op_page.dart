import 'package:flutter/material.dart';
import 'package:money_tracker/data/operation.dart';
import 'package:money_tracker/providers/operation_provider.dart';
import 'package:money_tracker/views/widget_tree.dart';
import 'package:provider/provider.dart';

class OpPage extends StatefulWidget {
  final int index;
  
  OpPage({super.key, required this.index});

  @override
  State<OpPage> createState() => _OpPageState();
}

class _OpPageState extends State<OpPage> {
  late Operation operation;
  @override
  void initState() {
    super.initState();
    operation = Provider.of<OperationProvider>(context, listen: false).ops[widget.index];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
        backgroundColor: Colors.purpleAccent,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 30
        ),
        title: Text(
          'Data by ${operation.type}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 13, right: 13, top: 13, bottom: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4, top: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Created',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(operation.date)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4, top: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        operation.category
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4, top: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Count',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${operation.count} rub.'
                      ),
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Provider.of<OperationProvider>(context, listen: false).deleteOp(widget.index);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => WidgetTree()
                      ),
                      (route) => false
                    );
                  },
                  icon: const Icon(
                    Icons.highlight_remove,
                    color: Colors.white,
                    size: 40,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    fixedSize: Size(60, 60),
                    backgroundColor: Color.fromARGB(255, 158, 6, 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}