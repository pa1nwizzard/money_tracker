import 'package:flutter/material.dart';
import 'package:money_tracker/data/operation.dart';
import 'package:money_tracker/providers/operation_provider.dart';
import 'package:money_tracker/views/widget_tree.dart';
import 'package:money_tracker/views/widgets/my_radio_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class CreatorOpPage extends StatefulWidget {
  const CreatorOpPage({super.key});

  @override
  State<CreatorOpPage> createState() => _CreatorOpPageState();
}

class _CreatorOpPageState extends State<CreatorOpPage> {
  final _controllerSum = TextEditingController();
  final _controllerCat = TextEditingController();
  //late List<Operation> ops = context.watch<OperationProvider>().ops;

  /*void initState() {
    super.initState();
    ops = context.watch<OperationProvider>().ops;
  }*/

  void _onCreateButtonPressed() {
    Operation operation = Operation(
                            id: Provider.of<OperationProvider>(context, listen: false).ops.length,
                            type: _selectedType!,
                            category: _selectedCategory!,
                            count: _controllerSum.text == '' ? 0 : double.tryParse(_controllerSum.text)!,
                            date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()
                          );
    insertOperation(operation);
    Provider.of<OperationProvider>(context, listen: false).add(operation);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (_) => WidgetTree()),
      (route) => false
    );
  }

  String? _selectedType = 'spend';
  String? _selectedCategory = 'food';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 30
        ),
        backgroundColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
        title: Text(
          'Create operation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    MyRadioListTile(
                      value: 'spend',
                      color: Colors.purpleAccent,
                      shape: 10,
                      groupValue: _selectedType,
                      name: 'Spend',
                      onChanged: (value) => setState(() => _selectedType = value!),
                    ),
                    MyRadioListTile(
                      value: 'income',
                      color: Colors.purpleAccent,
                      shape: 10,
                      groupValue: _selectedType,
                      name: 'Income',
                      onChanged: (value) => setState(() => _selectedType = value!),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32, top: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter sum..',
                      suffixText: 'rub.',
                      border: OutlineInputBorder()
                    ),
                    controller: _controllerSum,
                  ),
                ),
                Row(
                  children: [
                    MyRadioListTile(
                      value: 'food',
                      groupValue: _selectedCategory,
                      name: 'Food',
                      color: Colors.green,
                      onChanged: (value) => setState(() => _selectedCategory = value!),
                      shape: 20
                    ),
                    MyRadioListTile(
                      value: 'transfer',
                      groupValue: _selectedCategory,
                      name: 'Transfer',
                      color: Colors.green,
                      onChanged: (value) => setState(() => _selectedCategory = value!),
                      shape: 20
                    ),
                    MyRadioListTile(
                      value: 'entertainment',
                      groupValue: _selectedCategory,
                      name: 'Entertainment',
                      color: Colors.green,
                      onChanged: (value) => setState(() => _selectedCategory = value!),
                      shape: 20
                    ),
                  ],
                ),
                Row(
                  children: [
                    MyRadioListTile(
                      value: 'credit',
                      groupValue: _selectedCategory,
                      name: 'Credit',
                      color: Colors.green,
                      onChanged: (value) => setState(() => _selectedCategory = value!),
                      shape: 20
                    ),
                    MyRadioListTile(
                      value: 'salary',
                      groupValue: _selectedCategory,
                      name: 'Salary',
                      color: Colors.green,
                      onChanged: (value) => setState(() => _selectedCategory = value!),
                      shape: 20
                    ),
                    MyRadioListTile(
                      value: 'gift',
                      groupValue: _selectedCategory,
                      name: 'Gift',
                      color: Colors.green,
                      onChanged: (value) => setState(() => _selectedCategory = value!),
                      shape: 20
                    ),
                    MyRadioListTile(
                      value: _controllerCat.text,
                      groupValue: _selectedCategory,
                      name: 'Other',
                      color: Colors.green,
                      onChanged: (value) => setState(() => _selectedCategory = value),
                      shape: 20
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextField(
                    controller: _controllerCat,
                    decoration: InputDecoration(
                      hintText: 'Other category..',
                      border: OutlineInputBorder()
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
              ],
            ),
        
          
            
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: _onCreateButtonPressed,
                child: Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}