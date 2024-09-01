import 'package:conta/config/theme.dart';
import 'package:flutter/material.dart';

class TabButtons extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  const TabButtons({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.bgPeach,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              minimumSize: const Size(0, 0),
              backgroundColor: currentIndex == 0 ? Colors.white : AppColors.bgPeach,
              foregroundColor: Colors.black,
              shape: const StadiumBorder(),
              elevation: currentIndex == 0 ? 6 : 0,
            ),
            onPressed: () => onTabChanged(0),
            child: const Text('Balance', style: TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              minimumSize: const Size(0, 0),
              backgroundColor: currentIndex == 1 ? Colors.white : AppColors.bgPeach,
              foregroundColor: Colors.black,
              shape: const StadiumBorder(),
              elevation: currentIndex == 1 ? 6 : 0,
            ),
            onPressed: () => onTabChanged(1),
            child: const Text('Category', style: TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              minimumSize: const Size(0, 0),
              backgroundColor: currentIndex == 2 ? Colors.white : AppColors.bgPeach,
              foregroundColor: Colors.black,
              shape: const StadiumBorder(),
              elevation: currentIndex == 2 ? 6 : 0,
            ),
            onPressed: () => onTabChanged(2),
            child: const Text('Members', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
