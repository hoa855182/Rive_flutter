import 'package:flutter/material.dart';
import 'package:rive_animation/models/rive_assets.dart';

class AnimateBar extends StatelessWidget {
  const AnimateBar({
    Key? key,
    required this.selectedBottomNav,
    required this.isActive,
  }) : super(key: key);

  final RiveAsset selectedBottomNav;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 2),
      duration: const Duration(milliseconds: 200),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
          color: Color(0xFF81B4FF),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          )),
    );
  }
}
