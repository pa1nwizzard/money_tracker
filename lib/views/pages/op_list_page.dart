import 'package:flutter/material.dart';
import 'package:money_tracker/data/operation.dart';
import 'package:money_tracker/views/pages/op_page.dart';

class OpListPage extends StatefulWidget {
  OpListPage({super.key});

  @override
  State<OpListPage> createState() => _OpListPageState();
}

class _OpListPageState extends State<OpListPage> {

  late ValueNotifier<List<Operation>> ops;
  
  @override
  void initState() {
    super.initState();
    ops = ValueNotifier([]);
    _loadOperations();
  }

  void _loadOperations() async{
    ops.value = await getOperations();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ops,
      builder: (context, opsList, _) {
        return ListView.builder(
          itemCount: opsList.length,
          itemBuilder: (context, index) {
            final op = opsList[index];
            return ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => OpPage(operation: opsList[index])
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(0, 0, 0, 0),
                shadowColor: Color.fromARGB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(op.category),
                  Text(op.date),
                  Text(
                    op.type == 'spend' ? '-${op.count} rub.' : '+${op.count} rub.',
                    style: TextStyle(
                      color: op.type == 'spend' ? Colors.redAccent : Colors.lightGreen,
                    )
                  ),
                ],
              )
            );
          },
        );
      }
    );
  }
}
