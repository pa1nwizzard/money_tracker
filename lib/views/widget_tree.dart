import 'package:flutter/material.dart';
import 'package:money_tracker/data/notifiers.dart';
import 'package:money_tracker/providers/operation_provider.dart';
import 'package:money_tracker/views/pages/home_page.dart';
import 'package:money_tracker/views/pages/op_list_page.dart';
import 'package:money_tracker/views/widgets/navbar_widget.dart';
import 'package:provider/provider.dart';

var pages = [
  HomePage(),
  OpListPage()
];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<OperationProvider>(context, listen: false);
      provider.initDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'M O N E Y   T R A C K E R',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      ),
      //drawer: Drawer(),
      body: ValueListenableBuilder(valueListenable: selectedPageNotifier, builder: (context, value, child) {
        return pages.elementAt(value);
      }),
      bottomNavigationBar: NavbarWidget(),
      
      
    );
  }
}
