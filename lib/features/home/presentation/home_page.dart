import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/features/home/presentation/hero_widget.dart';
import 'package:video01_portfolio_website/features/home/presentation/home_course_list.dart';
import 'package:video01_portfolio_website/styles/app_size.dart';
import 'package:video01_portfolio_website/widgets/appbar/background_blur.dart';
import 'package:video01_portfolio_website/widgets/appbar/drawer_menue.dart';
import 'package:video01_portfolio_website/widgets/appbar/my_app_bar.dart';

import 'firestore_test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _coursesKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> drawerNotifier = ValueNotifier(false);
    return Scaffold(
      drawer: AppDrawerMenu(),
    onDrawerChanged: (isOpen) {
        drawerNotifier.value = isOpen;
       },
      body: Stack(
        children: [
          /// BACKGROUND BLUR BALLS
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

          /// YOUR APP BAR


          // SingleChildScrollView(
          //   physics: const AlwaysScrollableScrollPhysics(),
          //   child: Column(
          //     children: [
          //
          //       SizedBox(
          //         child: HeroWidget(),
          //
          //         height: 650,width:  double.infinity,),
          //
          //       Container(
          //         child: HomeCourseList(),
          //         height: 600,color: Colors.transparent,)
          //
          //
          //     ],
          //   ),
          // ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: BoxConstraints(maxWidth: Insets.maxwidth),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: 650, child: HeroWidget()),
                  ),
                  SliverToBoxAdapter(
                    key: _coursesKey,
                    child: SizedBox(height: 6000, child: HomeCourseList()),
                  ),

                ],
              ),
            ),
          ),




          MyAppBar(drawerNotifier: drawerNotifier),


        ],
      ),
    );
  }
  /// Function to scroll to course section
  void scrollToCourses() {
    Scrollable.ensureVisible(
      _coursesKey.currentContext!,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

}


