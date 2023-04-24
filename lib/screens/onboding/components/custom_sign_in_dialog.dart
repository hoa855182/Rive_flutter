 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive_animation/screens/onboding/components/sign_in_form.dart';

Future<Object?> customSigninDialog(BuildContext context,
      {required ValueChanged onClose}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Sign In",
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: (_, animation, __, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child,
          );
        },
        pageBuilder: (context, _, __) => Center(
                child: Container(
              height: 620,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.94),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Access to 240+ hours of content. Learn design and code, by building real apps with Flutter and Swift.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SignInForm(),
                        Row(
                          children: const [
                            Expanded(
                              child: Divider(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            "Sign up with Email, Apple or Google",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                "assets/icons/email_box.svg",
                                height: 64,
                                width: 64,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                "assets/icons/apple_box.svg",
                                height: 64,
                                width: 64,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                "assets/icons/google_box.svg",
                                height: 64,
                                width: 64,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: -48,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))).then(onClose);
  }