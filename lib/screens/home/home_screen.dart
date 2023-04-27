import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive_animation/models/course.dart';
import 'package:rive_animation/screens/home/components/course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Courses",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 20),
            //   child: CourseCard(
            //     title: "Animations in SwiftUI",
            //   ),
            // )
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: courses
                    .map((course) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CourseCard(course: course),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Recent",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ...recentCourses
                .map((course) => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: SecondaryCourseCard(
                        title: course.title,
                        iconsSrc: course.iconSrc,
                        colorl: course.color,
                      ),
                    ))
                .toList(),
          ]))),
    );
  }
}

class SecondaryCourseCard extends StatelessWidget {
  const SecondaryCourseCard({
    Key? key,
    required this.title,
    this.iconsSrc = "assets/icons/ios.svg",
    this.colorl = const Color(0xFF7553F6),
  }) : super(key: key);

  final String title, iconsSrc;
  final Color colorl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
          color: colorl,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Watch video - 15 mins",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              // thickness: 5,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(iconsSrc)
        ],
      ),
    );
  }
}
