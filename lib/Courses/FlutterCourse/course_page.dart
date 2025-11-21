import 'dart:ui';

import 'dart:html' as html;


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:video01_portfolio_website/features/home/presentation/home_course_list.dart';
import 'package:video01_portfolio_website/features/home/presentation/video.dart';

import '../../features/home/presentation/all_course_data.dart';

import '../../features/home/presentation/course.dart';




import '../../features/home/presentation/course_item.dart';
import '../../styles/app_size.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar/background_blur.dart';
import '../../widgets/appbar/drawer_menue.dart';
import '../../widgets/appbar/my_app_bar.dart';



// NOTE: This assumes you have imported the CourseDataEn, CourseDataSi,
// Course, SubCourse, and the RelatedCourseListDesktopMode classes correctly.




class CourseDetailPageContent extends StatelessWidget {
  final Course course;
  final bool isSinhala; // Current language (passed from navigation)

  const CourseDetailPageContent({
    super.key,
    required this.course,
    required this.isSinhala,
  });

  // Get ALL courses from the single source.
  List<Course> get _allCourses => AllCourseData.allCourses;

  // Get the current course object details (including videos)
  Course get _currentCourseDetails =>
      _allCourses.firstWhere((c) => c.id == course.id, orElse: () => course);

  // Related courses (exclude current) - used for the list at the bottom
  List<Course> get _relatedCourses =>
      _allCourses.where((c) => c.id != course.id).toList();

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16.0;
    const double verticalSpacing = 16.0;

    // --- Localization ---
    final Course courseData = _currentCourseDetails;
    final String localizedTitle = isSinhala ? courseData.titleSi : courseData.titleEn;
    final String localizedDescription = isSinhala ? courseData.descriptionSi : courseData.descriptionEn;

    // --- Course Data for Lessons ---
    // The lessons list will be the local 'videos' property
    final List<Videos> localLessons = courseData.videos;

    // The course object used to pass lessons to the list widgets
    final Course courseWithLessons = courseData; // Already contains the videos

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // --- Category Title ---
          Text(
            isSinhala ? "සියලුම පාඨමාලා" : "All Courses", // Placeholder category
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0xFFE0AFFF),
            ),
          ),
          const SizedBox(height: 8),

          // --- Main Title (Localized) ---
          Text(
            localizedTitle,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 24),

          // --- Main Description (Localized) ---
          Text(
            localizedDescription,
            style: const TextStyle(fontSize: 18, height: 1.5, color: Colors.white70),
          ),
          const SizedBox(height: 30),

          // -------------------------------------------------------------
          // 1. RESTORED: All Course List Container (The Lessons List)
          // -------------------------------------------------------------
          Container(
            height: 800,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF1E1E1E), Color(0xFF2C2C2C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
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
                child: SingleChildScrollView( // Provides inner scrolling for lessons
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    // Use the modified list component for lessons
                    child: localLessons.isEmpty
                        ? Center(child: Text(isSinhala ? "පාඩම් නැත" : "No Lessons", style: TextStyle(color: Colors.white70)))
                        : AllCourseListAccessPoint(course: courseWithLessons),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // -------------------------------------------------------------
          // 2. RESTORED: Related Courses List
          // -------------------------------------------------------------

          // --- Related Courses Title ---
          Text(
            isSinhala ? "මෙම පාඨමාලා සමානව" : "More Courses Like This",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),

          // --- Related Courses List ---
          ListView.separated(
            shrinkWrap: true,
            // Since the entire CoursePage should be in a SingleChildScrollView,
            // NeverScrollableScrollPhysics is correct here.
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _relatedCourses.length,
            separatorBuilder: (context, index) =>
            const SizedBox(height: verticalSpacing),
            itemBuilder: (context, index) {
              final relatedCourse = _relatedCourses[index];

              // Localize related course titles/descriptions
              final String relatedTitle = isSinhala ? relatedCourse.titleSi : relatedCourse.titleEn;
              final String relatedDescription = isSinhala ? relatedCourse.descriptionSi : relatedCourse.descriptionEn;

              return CourseItem(
                isMobile: true,
                imageUrl: relatedCourse.imageUrl,
                // 🎯 Use localized related course content
                title: relatedTitle,
                description: relatedDescription,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoursePage(
                        course: relatedCourse,
                        IsSinhala: isSinhala, // Use isSinhala, assuming CoursePage uses this case
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

// --- MAIN COURSE PAGE (Stateful structure provided by user) ---

class CoursePage extends StatefulWidget {
  // 💡 MANDATORY: Accepts the specific course data
  final Course course;

  final bool IsSinhala;

  const CoursePage({super.key, required this.course, required this.IsSinhala,});

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
                    child: CourseDetailPageContent(course: widget.course,isSinhala: widget.IsSinhala,),
                  ),

                ],
              ),
            ),
          ),

          // Custom AppBar (fixed on top of the content)
          // MyAppBar must be after the CustomScrollView in the Stack to overlay it
         // MyAppBar(drawerNotifier: drawerNotifier),
        ],
      ),
    );
  }
}


class RelatedCourseListDesktopMode extends StatelessWidget {
  // Course object now contains the 'videos' (formerly subCourses) list.
  final Course course;

  const RelatedCourseListDesktopMode({
    super.key,
    required this.course,
  });

  // Handle tap: free → YouTube / paid → Payment
  Future<void> _handleSubCourseTap(BuildContext context, Videos item) async {
    // This logic remains the same, assuming 'Videos' model has 'isPaid' and 'youtubeUrl'.
    // Ensure LaunchMode and launchUrlString are imported.

    if (item.isPaid) {
      const paymentUrl = "https://your-payment-portal.com"; // Replace

      if (!await launchUrlString(paymentUrl,
          mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open payment portal")),
        );
      }
    } else {
      if (!await launchUrlString(item.youtubeUrl,
          mode: LaunchMode.externalApplication)) {
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
    final locale = Localizations.localeOf(context);
    final isSinhala = locale.languageCode == 'si';
    const int itemsPerRow = 3;

    // 1. MODIFIED: Use the 'videos' property.
    final List<Videos> videos = course.videos;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          if (videos.isEmpty)
            Text(
              isSinhala
                  ? "මෙම පාඨමාලාවේ උප පාඨමාලා නොමැත"
                  : "No sub-courses available",
              style: const TextStyle(color: Colors.red),
            ),

          // GRID UI
          for (int i = 0; i < videos.length; i += itemsPerRow)
            Padding(
              padding: EdgeInsets.only(
                bottom: i + itemsPerRow < videos.length ? rowSpacing : 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(itemsPerRow, (index) {
                  final dataIndex = i + index;

                  if (dataIndex < videos.length) {
                    final Videos item = videos[dataIndex];

                    // 2. MODIFIED: Select the correct localized title and description
                    final String localizedTitle = isSinhala ? item.titleSi : item.titleEn;
                    final String localizedDescription = isSinhala ? item.descriptionSi : item.descriptionEn;


                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: index < itemsPerRow - 1 ? columnSpacing : 0,
                        ),
                        child: Stack(
                          children: [
                            CourseItem(
                              isMobile: false,
                              imageUrl: item.imageUrl,
                              // 3. MODIFIED: Pass localized content
                              title: localizedTitle,
                              description: localizedDescription,
                              onTap: () => _handleSubCourseTap(context, item),
                            ),

                            // Paid badge
                            if (item.isPaid)
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.lock,
                                          color: Colors.white, size: 16),
                                      const SizedBox(width: 6),
                                      Text(
                                        isSinhala
                                            ? "ගෙවූ වීඩියෝ"
                                            : "Paid Video",
                                        style: const TextStyle(
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

  // Handle tap: free → YouTube / paid → Payment
  Future<void> _handleSubCourseTap(BuildContext context, Videos item) async {
    // Assuming the Videos model has isPaid and youtubeUrl properties
    if (item.isPaid) {
      const paymentUrl = "https://your-payment-portal.com";

      if (!await launchUrlString(paymentUrl, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open payment portal")),
        );
      }
      return;
    }

    // Free → YouTube
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
    const int itemsPerRow = 2; // Mobile grid (Matching image c5305d)
    final locale = Localizations.localeOf(context);
    final isSinhala = locale.languageCode == 'si';

    // Use the 'videos' list from the passed Course object
    final List<Videos> videos = course.videos;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        children: [
          if (videos.isEmpty) // Check the videos list
            Text(
              isSinhala
                  ? "මෙම පාඨමාලාවේ උප පාඨමාලා නොමැත"
                  : "No sub-courses available",
              style: const TextStyle(color: Colors.red),
            ),

          // --- GRID LOOP (Creates 2 items per row) ---
          for (int i = 0; i < videos.length; i += itemsPerRow)
            Padding(
              padding: EdgeInsets.only(
                bottom: (i + itemsPerRow < videos.length) ? rowSpacing : 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(itemsPerRow, (index) {
                  final dataIndex = i + index;

                  if (dataIndex < videos.length) {
                    final Videos item = videos[dataIndex];

                    // Select the correct localized title and description
                    final String localizedTitle = isSinhala ? item.titleSi : item.titleEn;
                    final String localizedDescription = isSinhala ? item.descriptionSi : item.descriptionEn;

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: index < itemsPerRow - 1 ? columnSpacing : 0,
                        ),

                        // ✔ STYLED MOBILE CARD CONTAINER
                        child: _MobileCourseCard(
                          child: Stack(
                            children: [
                              CourseItem(
                                isMobile: true,
                                imageUrl: item.imageUrl,
                                title: localizedTitle,
                                description: localizedDescription,
                                onTap: () => _handleSubCourseTap(context, item),
                              ),

                              // ---- GOLD PAID BADGE (Matching image c5305d) ----
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
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      isSinhala
                                          ? "ගෙවූ වීඩියෝව"
                                          : "PAID",
                                      style: const TextStyle(
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
