import 'package:flutter/material.dart';
import 'package:oshifit/ui/screens/outfit_board_screen.dart';
import '../ui/widgets/navigation.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/favorite_screen.dart';

class AppControllers extends StatefulWidget {
  const AppControllers({super.key});

  @override
  State<AppControllers> createState() => _AppControllersState();
}

class _AppControllersState extends State<AppControllers> {
  int currentIndex = 0;
  final pages = [HomeScreen(), OutfitBoardScreen(), FavoriteScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4E6),
      body: IndexedStack(index: currentIndex, children: pages),
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
