import 'package:flutter/material.dart';
import 'package:money_tracker/data/notifiers.dart';
import 'package:money_tracker/views/pages/home_page.dart';
import 'package:money_tracker/views/pages/op_list_page.dart';
import 'package:money_tracker/views/widgets/navbar_widget.dart';

var pages = [
  HomePage(),
  OpListPage()
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

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
