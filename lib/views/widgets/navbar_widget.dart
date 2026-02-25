import 'package:flutter/material.dart';
import 'package:money_tracker/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: const Icon(Icons.home), label: 'Main'),
            NavigationDestination(icon: const Icon(Icons.monetization_on_outlined), label: 'Operations')
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      }
    );
  }
}
