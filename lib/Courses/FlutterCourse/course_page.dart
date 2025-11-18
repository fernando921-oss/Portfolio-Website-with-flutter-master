import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/features/home/presentation/home_course_list.dart';

import '../../features/home/presentation/course.dart';
import '../../features/home/presentation/course_data.dart';
import '../../Courses/FlutterCourse/fluttercourse_data.dart';


import '../../features/home/presentation/course_item.dart';
import '../../styles/app_size.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar/background_blur.dart';
import '../../widgets/appbar/drawer_menue.dart';
import '../../widgets/appbar/my_app_bar.dart';
import 'fluttercourse_data.dart';
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

          // --- Placeholder for Video/Lecture Content ---
          Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: FlutterHomeCourseListDesktop(course: course,)
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
class FlutterHomeCourseListDesktop extends StatelessWidget {
  final Course course;

  const FlutterHomeCourseListDesktop({
    super.key,
    required this.course,
  });

  // ✅ Get only related courses (exclude current)
  List<Course> get _relatedFlutterCourses {
    return FluttercourseData.allCourses
        .where((c) => c.id == course.id)
        .take(6)
        .toList();
  }


  final double columnSpacing = 20.0;
  final double rowSpacing = 20.0;

  Widget _buildCourseRow(BuildContext context, int startIndex) {
    const int itemsPerRow = 3;
    final List<Widget> rowItems = [];

    for (int i = 0; i < itemsPerRow; i++) {
      final int dataIndex = startIndex + i;

      if (dataIndex < _relatedFlutterCourses.length) {
        final Course item = _relatedFlutterCourses[dataIndex];

        rowItems.add(
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < 2 ? columnSpacing : 0),
              child: CourseItem(
                isMobile: false,
                imageUrl: item.imageUrl,
                title: item.title,
                description: item.description,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CoursePage(course: item),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      } else {
        rowItems.add(const Expanded(child: SizedBox.shrink()));
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalItems = _relatedFlutterCourses.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          _buildCourseRow(context, 0),

          if (totalItems > 3) SizedBox(height: rowSpacing),
          if (totalItems > 3) _buildCourseRow(context, 3),
        ],
      ),
    );
  }
}
