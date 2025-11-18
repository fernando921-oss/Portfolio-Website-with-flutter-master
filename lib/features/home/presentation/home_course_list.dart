
import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/extensions.dart';
import 'package:video01_portfolio_website/features/home/presentation/course_item.dart';

import '../../../Courses/FlutterCourse/course_page.dart';
import '../../../styles/app_size.dart';
import 'course.dart';
import 'course_data.dart';

class HomeCourseList extends StatelessWidget {
  const HomeCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define a breakpoint for switching between desktop and mobile layout
    const double mobileBreakpoint = 600.0;
    return Column(

      children: [
        // Responsive check: Use desktop layout for wider screens, mobile for smaller
        if (screenWidth > mobileBreakpoint)
          const HomeCourseListDesktop()
        else
          const HomeCourseListMobile(),
      ],


    );



  }
}




// Assuming Course, CourseData, CourseItem, CoursePage, and context extensions are imported

class HomeCourseListDesktop extends StatelessWidget {
  const HomeCourseListDesktop({super.key});

  final List<Course> courses = CourseData.allCourses;
  final double columnSpacing = 20.0;
  final double rowSpacing = 20.0;

  Widget _buildCourseRow(BuildContext context, int startIndex) {
    final List<Widget> rowItems = [];
    final int itemsPerRow = 3;

    for (int i = 0; i < itemsPerRow; i++) {
      final int dataIndex = startIndex + i;

      if (dataIndex < courses.length) {
        final Course course = courses[dataIndex];

        rowItems.add(
          Expanded(
            child: Padding(
              // The 'i < 2' check ensures spacing only between the first two items in a 3-item row
              padding: EdgeInsets.only(right: i < 2 ? columnSpacing : 0),
              child: CourseItem(
                isMobile: false,
                imageUrl: course.imageUrl,
                title: course.title,
                description: course.description,

                // 🚀 NEW: Add the onTap function to navigate
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Pass the specific 'course' object to the destination page
                      builder: (context) => CoursePage(course: course),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      } else {
        // Fill empty slots with Expanded SizedBox to maintain layout structure
        rowItems.add(const Expanded(child: SizedBox.shrink()));
      }
    }

    return Row(
      // Keep the crossAxisAlignment as start to handle cards of different heights
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Only shows up to 6 items (two rows)
    final int totalItems = courses.take(6).length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.Insets.Padding),
      child: Column(
        children: [
          // First row of courses (indices 0, 1, 2)
          _buildCourseRow(context, 0),

          // Add spacing if there is a second row
          if (totalItems > 3) SizedBox(height: rowSpacing),

          // Second row of courses (indices 3, 4, 5)
          if (totalItems > 3) _buildCourseRow(context, 3),
        ],
      ),
    );
  }
}

// home_course_list_mobile.dart

// Assuming you import the new files:
// import 'course.dart';
// import 'course_data.dart';


// Assuming Course, CourseData, CourseItem, and CoursePage are imported correctly
// import 'models/course.dart';
// import 'pages/course_page.dart';

class HomeCourseListMobile extends StatelessWidget {
  const HomeCourseListMobile({super.key});

  // Get the data list from the utility class
  final List<Course> courses = CourseData.allCourses;

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16.0;
    const double verticalSpacing = 16.0;

    // Item count is dynamically based on the list size
    final int itemCount = courses.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: ListView.separated(
        // Optimization properties
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(height: verticalSpacing),

        itemBuilder: (context, index) {
          final Course course = courses[index]; // Use the strongly typed Course object

          return CourseItem(
            isMobile: true,
            // Access properties directly from the Course object
            imageUrl: course.imageUrl,
            title: course.title,
            description: course.description,
            // 💡 NEW: onTap function for navigation
            onTap: () {
              // Navigate to CoursePage, passing the specific course object
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoursePage(course: course),
                ),
              );
            },
          );
        },
      ),
    );
  }
}