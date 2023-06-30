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
import 'dart:math';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  RiveAsset selectedBottomNav = bottomNav.first;
  late SMIBool isSideBarClosed;
  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;
  bool isSideMenuClosed = true;
  bool isSideBarOpen = false;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: backgroundColor2,
      body: Stack(
        children: [
          AnimatedPositioned(
            width: 288,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? -288 : 0,
            top: 0,
            child: const SideBar(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * (animation.value) * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scalAnimation.value,
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                  child: HomeScreen(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? 15 : 250,
            top: 16,
            child: MenuBtn(
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
                if (!isSideMenuClosed) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                setState(() {
                  isSideMenuClosed = isSideBarClosed.value;
                });
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
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
        ),
      ),
    );
  }
}
