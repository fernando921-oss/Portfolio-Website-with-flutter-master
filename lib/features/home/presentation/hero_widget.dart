import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video01_portfolio_website/extensions.dart';
import 'package:video01_portfolio_website/styles/app_size.dart';

import 'hero_button.dart';
import 'hero_image.dart';
import 'hero_text.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60,),
        Expanded(
          child: context.isDesktop || context.isTablet
              ? const _LargeHeroWidget()
              : const _SmallHeroWidget(),
        ),
      ],
    );
  }
}

class _SmallHeroWidget extends StatelessWidget {
  const _SmallHeroWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(constraints: const BoxConstraints(
            maxWidth:140 ),
          child: const HeroImage(),

        ),
        Gap(Insets.xl),
        HeroTexts(),
        Gap(Insets.xxxl),
        SmallHeroButtons(),

      ],
    );
  }
}

// class _LargeHeroWidget extends StatelessWidget {
//   const _LargeHeroWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//
//         Expanded(child: const HeroImage()),
//         //Gap(Insets.xxxl),
//         SizedBox(width: 50,),
//         Expanded(
//           flex: 2,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               const HeroTexts(),
//               SizedBox(height: 50),
//
//
//                  // SizedBox(width: 260,),
//                   const LargeHeroButtons(),
//
//
//             ],
//           ), // Column // Expanded
//         ),
//       ],
//     );
//   }
// }
class _LargeHeroWidget extends StatelessWidget {
  const _LargeHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Hero Image on the left
        Expanded(child: const HeroImage()),

        // Gap between image and text/buttons
        const SizedBox(width: 50),

        // Text and Buttons on the right
        Expanded(
          flex: 2,
          child: Column(
            // 1. **NEW:** Align children vertically in the middle of the Column
            mainAxisAlignment: MainAxisAlignment.center,

            // 2. Keep this to align text/buttons horizontally to the left
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeroTexts(),

              // Vertical gap between text and buttons
              const SizedBox(height: 50),

              const LargeHeroButtons(),
            ],
          ), // Column
        ),
      ],
    );
  }
}

