
import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/extensions.dart';
import 'package:video01_portfolio_website/features/home/presentation/course_item.dart';

import '../../../Courses/FlutterCourse/course_page.dart';
import '../../../styles/app_size.dart';
import 'all_course_data.dart';

import 'course.dart';


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

// Assuming your Course model now looks something like this:
/*
class Course {
  final int id;
  final String titleEn;
  final String titleSi;
  final String descriptionEn;
  final String descriptionSi;
  final String imageUrl;
  final String youtubeUrl;
  final List<Videos> videos; // Videos is the new SubCourse/lessons model
  // ... constructor
}
*/

class HomeCourseListDesktop extends StatelessWidget {
  const HomeCourseListDesktop({super.key});

  final double columnSpacing = 20.0;
  final double rowSpacing = 20.0;

  /// MODIFIED: Now gets the list from the single source.
  List<Course> _getCourses() {
    // 1. Get data from the single, merged file.
    return AllCourseData.allCourses;
  }

  /// Build one row of 3 items
  Widget _buildCourseRow(
      BuildContext context, List<Course> courses, int startIndex) {
    final lang = Localizations.localeOf(context).languageCode;
    final isSinhala = lang == "si";

    final List<Widget> rowItems = [];
    const int itemsPerRow = 3;

    for (int i = 0; i < itemsPerRow; i++) {
      final int dataIndex = startIndex + i;

      if (dataIndex < courses.length) {
        final Course course = courses[dataIndex];

        // 2. MODIFIED: Select the correct title and description based on language
        final String title = isSinhala ? course.titleSi : course.titleEn;
        final String description = isSinhala ? course.descriptionSi : course.descriptionEn;

        rowItems.add(
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < 2 ? columnSpacing : 0),
              child: CourseItem(
                isMobile: false,
                imageUrl: course.imageUrl,
                title: title, // Use the localized title
                description: description, // Use the localized description
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CoursePage(
                        course: course,
                        // 3. MODIFIED: Ensure the case matches (IsSinhala -> isSinhala)
                        IsSinhala: isSinhala,
                      ),
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
    // MODIFIED: Call _getCourses without the context argument
    final courses = _getCourses();
    final int totalItems = courses.take(6).length;

    // Assuming context.Insets.Padding is defined elsewhere or should be a standard value
    const double paddingValue = 40.0; // Placeholder value for context.Insets.Padding

    return Padding(
      // NOTE: Replace 'context.Insets.Padding' with a suitable constant or definition
      padding: const EdgeInsets.symmetric(horizontal: paddingValue),
      child: Column(
        children: [
          _buildCourseRow(context, courses, 0),
          if (totalItems > 3) SizedBox(height: rowSpacing),
          if (totalItems > 3) _buildCourseRow(context, courses, 3),
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


// Ensure AllCourseData, Course, CourseItem, and CoursePage are imported

class HomeCourseListMobile extends StatelessWidget {
  const HomeCourseListMobile({super.key});

  /// MODIFIED: Now gets the list from the single source AllCourseData.
  List<Course> _getCourses() {
    return AllCourseData.allCourses;
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16.0;
    const double verticalSpacing = 16.0;

    // MODIFIED: Get data without context, as localization is handled in the UI.
    final List<Course> courses = _getCourses();
    final lang = Localizations.localeOf(context).languageCode;
    final isSinhala = lang == "si";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: courses.length,
        separatorBuilder: (context, index) =>
        const SizedBox(height: verticalSpacing),
        itemBuilder: (context, index) {
          final Course course = courses[index];

          // ➡️ MODIFIED: Select the correct title and description based on language
          final String title = isSinhala ? course.titleSi : course.titleEn;
          final String description = isSinhala ? course.descriptionSi : course.descriptionEn;


          return CourseItem(
            isMobile: true,
            imageUrl: course.imageUrl,
            title: title, // Use the localized title
            description: description, // Use the localized description
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CoursePage(
                    course: course,
                    // ➡️ MODIFIED: Ensure the case matches (IsSinhala -> isSinhala)
                    IsSinhala: isSinhala,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
