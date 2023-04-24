import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/utils/rive_ultis.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAsset selectedBottomNav = bottomNav.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              bottomNav.length,
              (index) => GestureDetector(
                onTap: () {
                  bottomNav[index].input.change(true);
                  if (bottomNav[index] != selectedBottomNav) {
                    setState(() {
                      selectedBottomNav = bottomNav[index];
                    });
                  }
                  Future.delayed(const Duration(seconds: 1), () {
                    bottomNav[index].input.change(false);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimateBar(
                      selectedBottomNav: selectedBottomNav,
                      isActive: bottomNav[index] == selectedBottomNav,
                    ),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity:
                            bottomNav[index] == selectedBottomNav ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          bottomNav[index].src,
                          artboard: bottomNav[index].artboard,
                          onInit: (artboard) {
                            StateMachineController controller =
                                RiveUtils.getRiveController(
                              artboard,
                              stateMachineName:
                                  bottomNav[index].stateMachineName,
                            );
                            bottomNav[index].input =
                                controller.findSMI("active") as SMIBool;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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

class RiveAsset {
  final String artboard, stateMachineName, src;
  late SMIBool input;
  RiveAsset({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
  });
  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNav = [
  RiveAsset(
      src: "assets/RiveAssets/icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity"),
  RiveAsset(
    src: "assets/RiveAssets/icons.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
  ),
  RiveAsset(
      src: "assets/RiveAssets/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity"),
  RiveAsset(
      src: "assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity"),
  RiveAsset(
      src: "assets/RiveAssets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity")
];
