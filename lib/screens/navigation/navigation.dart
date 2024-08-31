/* Flutter Imports */
import 'package:conta/screens/expenses/expenses.dart';
import 'package:conta/screens/home/home.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _BaseState();
}

class _BaseState extends State<NavigationScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(10);

    const List<Widget> pages = [
      HomeScreen(),
      ExpensesScreen(),
    ];
    final List<IconData> icons = [
      Icons.person,
      Icons.add_circle_outline,
    ];
    const List<String> labels = [
      'Perfil',
      'Despesas',
    ];

    return Scaffold(
      body: IndexedStack(index: currentPageIndex, children: pages),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: radius,
          topRight: radius,
        ),
        child: NavigationBar(
          destinations: List.generate(icons.length, (index) {
            return NavigationDestination(
              icon: Icon(icons[index]),
              label: labels[index],
            );
          }),
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) => setState(() {
            currentPageIndex = index;
          }),
          animationDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
