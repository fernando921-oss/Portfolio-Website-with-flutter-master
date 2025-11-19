import 'dart:ui';

import 'dart:html' as html;


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video01_portfolio_website/features/home/presentation/home_course_list.dart';

import '../../features/home/presentation/course.dart';
import '../../features/home/presentation/course_data.dart';
import '../../Courses/FlutterCourse/all_course_data.dart';


import '../../features/home/presentation/course_item.dart';
import '../../styles/app_size.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar/background_blur.dart';
import '../../widgets/appbar/drawer_menue.dart';
import '../../widgets/appbar/my_app_bar.dart';
import 'all_course_data.dart';
// Assuming the mock dependencies are available via a file or package
// If using the dependencies.dart file, you would import it here:
// import 'dependencies.dart';

// --- COURSE DETAIL CONTENT WIDGET (Renders the course data) ---

class CourseDetailPageContent extends StatelessWidget {
  final Course course;

  const CourseDetailPageContent({super.key, required this.course});

  // Example of fetching related courses (excluding the current one)
  List<Course> get _relatedCourses {
    return CourseData.allCourses
        .where((c) => c.id != course.id)
        .take(6)
        .toList();
  }



  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16.0;
    const double verticalSpacing = 16.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Course Title and Details (Dynamic Content) ---
          SizedBox(height: 20,),
          Text(
            course.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900, // Use a very heavy weight for impact
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 0.5, // Add subtle spacing to breathe
              // Optional: Add a subtle shadow if your background is complex
              // shadows: [
              //   Shadow(
              //     offset: Offset(1.0, 1.0),
              //     blurRadius: 3.0,
              //     color: Colors.black45,
              //   ),
              // ],
            ),
          ),
          const SizedBox(height: 24),

          // --- Main Description ---
          Text(
            'Welcome to the detailed view for the ${course.title} course! This course focuses on: ${course.description}',
            style: const TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(height: 30),


        Container(
          height: 800,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E1E1E),
                Color(0xFF2C2C2C),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: true,
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: AllCourseListAccessPoint(course: course),
                ),
              ),
            ),
          ),
        ),





        const SizedBox(height: 40),

          // --- Related Courses Section Title ---
          Text(
            'More Courses Like This',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),

          // --- RELATED COURSE CARDS (Vertical List) ---
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Important for nested scrolling

            itemCount: _relatedCourses.length,
            separatorBuilder: (context, index) => const SizedBox(height: verticalSpacing),

            itemBuilder: (context, index) {
              final Course relatedCourse = _relatedCourses[index];

              return CourseItem(
                // Use mobile sizing for vertical list layout
                isMobile: true,
                imageUrl: relatedCourse.imageUrl,
                title: relatedCourse.title,
                description: relatedCourse.description,
                onTap: () {
                  // Navigate to the detail page for the related course
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoursePage(course: relatedCourse),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 50), // Extra space at the bottom
        ],
      ),
    );
  }
}


// --- MAIN COURSE PAGE (Stateful structure provided by user) ---

class CoursePage extends StatefulWidget {
  // 💡 MANDATORY: Accepts the specific course data
  final Course course;

  const CoursePage({super.key, required this.course});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> drawerNotifier = ValueNotifier(false);

    return Scaffold(
      // The default drawer is AppDrawerMenu
      drawer: AppDrawerMenu(),
      onDrawerChanged: (isOpen) {
        drawerNotifier.value = isOpen;
      },

      // Use the course title for the browser/window title (if applicable)
      // appBar: AppBar(
      //   title: Text(widget.course.title),
      //   backgroundColor: Colors.transparent, // Custom AppBar handles visuals
      //   elevation: 0,
      // ),

      body: Stack(
        children: [
          /// BACKGROUND BLUR BALLS (as provided)
          const BlurBall(
            size: 450,
            color: Color(0xFF9D4EDD),    // Purple glow
            offset: Offset(-150, -120),   // top-left
          ),
          const BlurBall(
            size: 300,
            color: Color(0xFF7B2CBF),     // darker purple
            offset: Offset(900, 200),      // right-middle
          ),
          const BlurBall(
            size: 350,
            color: Color(0xFFE0AFFF),      // pinkish
            offset: Offset(200, 500),       // bottom
          ),

          /// MAIN SCROLLING CONTENT
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: Insets.maxwidth),
              child: CustomScrollView(
                slivers: [
                  // 1. Spacing to account for the custom AppBar height
                  SliverToBoxAdapter(
                    child: SizedBox(height: 60),
                  ),

                  // 2. The main course content
                  SliverToBoxAdapter(
                    // 💡 Inject dynamic content here
                    child: CourseDetailPageContent(course: widget.course),
                  ),

                ],
              ),
            ),
          ),

          // Custom AppBar (fixed on top of the content)
          // MyAppBar must be after the CustomScrollView in the Stack to overlay it
          MyAppBar(drawerNotifier: drawerNotifier),
        ],
      ),
    );
  }
}

class RelatedCourseListDesktopMode extends StatelessWidget {
  final Course course;

  const RelatedCourseListDesktopMode({
    super.key,
    required this.course,
  });

  // Show ALL courses (for testing)
  List<Course> get _relatedCourseData {
    return AllcourseData.allCourses.where((c) => c.id == course.id).take(10).toList();
  }

  // Handle course tap: YouTube for free, payment for paid
  Future<void> _handleCourseTap(BuildContext context, Course item) async {
    if (item.isPaid) {
      const paymentUrl = "https://your-payment-portal.com"; // replace with your payment link
      if (kIsWeb) {
        html.window.open(paymentUrl, '_blank');
      } else {
        if (!await launchUrlString(paymentUrl, mode: LaunchMode.externalApplication)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Could not open payment portal")),
          );
        }
      }
    } else {
      // Free course → open YouTube
      if (!await launchUrlString(item.youtubeUrl, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open YouTube video")),
        );
      }
    }
  }

  final double columnSpacing = 20.0;
  final double rowSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    const int itemsPerRow = 3;

    final courses = _relatedCourseData;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          if (courses.isEmpty)
            const Text("No courses found", style: TextStyle(color: Colors.red)),

          for (int i = 0; i < courses.length; i += itemsPerRow)
            Padding(
              padding: EdgeInsets.only(
                bottom: i + itemsPerRow < courses.length ? rowSpacing : 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(itemsPerRow, (index) {
                  final dataIndex = i + index;

                  if (dataIndex < courses.length) {
                    final item = courses[dataIndex];

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: index < itemsPerRow - 1 ? columnSpacing : 0),
                        child: Stack(
                          children: [
                            CourseItem(
                              isMobile: false,
                              imageUrl: item.imageUrl,
                              title: item.title,
                              description: item.description,
                              onTap: () => _handleCourseTap(context, item),
                            ),

                            // === Beautiful Paid Badge ===
                            if (item.isPaid)
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.lock, color: Colors.white, size: 16),
                                      SizedBox(width: 6),
                                      Text(
                                        "Paid Video",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),

                      ),
                    );
                  } else {
                    return const Expanded(child: SizedBox.shrink());
                  }
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class RelatedCourseListMobileMode extends StatelessWidget {
  final Course course;

  const RelatedCourseListMobileMode({
    super.key,
    required this.course,
  });

  // Show ALL courses (testing)
  List<Course> get _relatedFlutterCourses {
    return AllcourseData.allCourses
        .where((c) => c.id == course.id)
        .take(10)
        .toList();
  }

  Future<void> _handleCourseTap(BuildContext context, Course item) async {
    if (item.isPaid) {
      const paymentUrl = "https://your-payment-portal.com";

      if (!await launchUrlString(paymentUrl, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open payment portal")),
        );
      }
      return;
    }

    // free → YouTube
    if (!await launchUrlString(item.youtubeUrl, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open YouTube video")),
      );
    }
  }

  final double columnSpacing = 12.0;
  final double rowSpacing = 18.0;

  @override
  Widget build(BuildContext context) {
    const int itemsPerRow = 2; // Mobile grid
    final courses = _relatedFlutterCourses;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        children: [
          if (courses.isEmpty)
            const Text(
              "No courses found",
              style: TextStyle(color: Colors.red),
            ),

          // --- GRID LOOP ---
          for (int i = 0; i < courses.length; i += itemsPerRow)
            Padding(
              padding: EdgeInsets.only(
                bottom: (i + itemsPerRow < courses.length) ? rowSpacing : 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(itemsPerRow, (index) {
                  final dataIndex = i + index;

                  if (dataIndex < courses.length) {
                    final item = courses[dataIndex];

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: index < itemsPerRow - 1 ? columnSpacing : 0,
                        ),

                        // ✔ Stack sits inside BEAUTIFUL CARD
                        child: _MobileCourseCard(
                          child: Stack(
                            children: [
                              CourseItem(
                                isMobile: true,
                                imageUrl: item.imageUrl,
                                title: item.title,
                                description: item.description,
                                onTap: () => _handleCourseTap(context, item),
                              ),

                              // ---- BEAUTIFUL PAID BADGE ----
                              if (item.isPaid)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFF7D358),
                                          Color(0xFFFACC2E),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Text(
                                      "PAID",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Expanded(child: SizedBox());
                  }
                }),
              ),
            ),
        ],
      ),
    );
  }
}


/// --------------------------
///  BEAUTIFUL MOBILE CARD UI
/// --------------------------
class _MobileCourseCard extends StatelessWidget {
  final Widget child;

  const _MobileCourseCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: child,
      ),
    );
  }
}


class AllCourseListAccessPoint extends StatelessWidget {
  final Course course;
  const AllCourseListAccessPoint({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define a breakpoint for switching between desktop and mobile layout
    const double mobileBreakpoint = 600.0;
    return Column(

      children: [
        // Responsive check: Use desktop layout for wider screens, mobile for smaller
        if (screenWidth > mobileBreakpoint)
          RelatedCourseListDesktopMode(course: course)
        else
           RelatedCourseListMobileMode(course: course,),
      ],


    );



  }
}
