import 'package:flutter/material.dart';
import '../ui/widgets/navigation.dart';
import '../ui/screens/home_screen.dart';

class AppControllers extends StatefulWidget {
  const AppControllers({super.key});

  @override
  State<AppControllers> createState() => _AppControllersState();
}

class _AppControllersState extends State<AppControllers> {
  int currentIndex = 0;
  final pages = [
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navigation(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
