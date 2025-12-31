import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const Navigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        margin: EdgeInsets.all(20),
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF456882),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navItem(Icons.home_filled, 0),
            _navItem(Icons.grid_view_outlined, 1),
            _navItem(Icons.favorite_border_outlined, 2)
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Color(0xFFFFF4E6) : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 32,
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
