import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/models/menu.dart';
import 'package:rive_animation/screens/entry_point/components/info_card.dart';
import 'package:rive_animation/screens/entry_point/components/side_menu.dart';
import 'package:rive_animation/utils/rive_ultis.dart';

// import '../../../models/rive_assets.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Menu selectedMenu = sidebarMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        body: SafeArea(
            child: Container(
          width: 288,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF17203A),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: "Edrig",
                bio: "Developer",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus.map(
                (menu) => SideMenu(
                  menu: menu,
                  riveOnInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.rive.stateMachineName);
                    menu.rive.status = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.rive.status?.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.rive.status?.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isAcitve: selectedMenu == menu,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "History".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus2.map(
                (menu) => SideMenu(
                  menu: menu,
                  riveOnInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.rive.stateMachineName);
                    menu.rive.status = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.rive.status?.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.rive.status?.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isAcitve: selectedMenu == menu,
                ),
              ),
            ],
          )),
        )));
  }
}
