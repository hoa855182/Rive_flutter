import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/components/animate_bar.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/models/rive_assets.dart';
import 'package:rive_animation/screens/entry_point/components/menu_btn.dart';
import 'package:rive_animation/screens/entry_point/components/side_bar.dart';
import 'package:rive_animation/screens/entry_point/components/side_menu.dart';
import 'package:rive_animation/screens/home/home_screen.dart';
import 'package:rive_animation/utils/rive_ultis.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAsset selectedBottomNav = bottomNav.first;
  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          Positioned(
              width: 288,
              height: MediaQuery.of(context).size.height,
              child: const SideBar()),
          Transform.translate(
            offset: Offset(288, 0),
            child: Transform.scale(
                scale: isSideMenuClosed ? 1 : 0.8,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: const HomeScreen())),
          ),
          MenuBtn(
            riveOnInit: ((artboard) {
              StateMachineController controller = RiveUtils.getRiveController(
                artboard,
                stateMachineName: "State Machine",
              );
              isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
              isSideBarClosed.value = true;
            }),
            press: () {
              isSideBarClosed.value = !isSideBarClosed.value;
              setState(() {
                isSideMenuClosed = isSideBarClosed.value;
              });
            },
          )
        ],
      ),
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
