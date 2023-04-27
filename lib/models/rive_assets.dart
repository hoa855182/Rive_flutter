import 'package:rive/rive.dart';

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

List<RiveAsset> sidebarMenus = [
  RiveAsset(
      src: "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity"),
  RiveAsset(
      src: "assets/RiveAssets/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity"),
  RiveAsset(
      src: "assets/RiveAssets/icons.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity"),
  RiveAsset(
      src: "assets/RiveAssets/icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity"),
];
