import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';
import 'package:video01_portfolio_website/extensions.dart';

import '../../../widgets/appbar/seo_text.dart';

// class HeroTexts extends StatelessWidget {
//   const HeroTexts({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: context.isDesktopOrTablet
//           ? CrossAxisAlignment.start
//           : CrossAxisAlignment.center,
//       children: [
//         SEOText(
//           "Teacher's Guide",
//           textAlign:
//           context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//           style: context.textStyle.titleSmBold.copyWith(
//             color: context.colorscheme.onBackground,
//           ),
//           textRendererStyle: TextRendererStyle.header1,
//         ),
//         SizedBox(height: 8),
//
//         SEOText(
//           "Learn Math and Code",
//           textAlign:
//           context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//           style: context.textStyle.titleMdMedium.copyWith(
//             color: context.colorscheme.onBackground,
//           ),
//           textRendererStyle: TextRendererStyle.header2,
//         ),
//     SizedBox(height: 8),
//         SEOText(
//           "Mobile app developer",
//           textAlign:
//           context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//           style: context.textStyle.bodyMdMedium.copyWith(
//             color: context.colorscheme.onSurface,
//           ),
//           textRendererStyle: TextRendererStyle.header3,
//         ),
//       ],
//     );
//   }
// }
// class HeroTexts extends StatelessWidget {
//   const HeroTexts({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: context.isDesktopOrTablet
//           ? CrossAxisAlignment.start
//           : CrossAxisAlignment.center,
//       children: [
//
//         // Replace this:
//         // SEOText(
//         //   "Teacher's Guide",
//         //   ...
//         // )
//
//         // With this:
//         if (kIsWeb)
//           SEOText(
//             "Teacher's Guide",
//             textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//             style: context.textStyle.titleSmBold.copyWith(
//               color: context.colorscheme.onBackground,
//             ),
//             textRendererStyle: TextRendererStyle.header1,
//           )
//         else
//           Text(
//             "Teacher's Guide",
//             style: context.textStyle.titleSmBold.copyWith(
//               color: context.colorscheme.onBackground,
//             ),
//             textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//           ),
//
//         SizedBox(height: 8),
//
//         // Do the same for the other SEOText widgets below
//         if (kIsWeb)
//           SEOText(
//             "Learn Math and Code",
//             textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//             style: context.textStyle.titleMdMedium.copyWith(
//               color: context.colorscheme.onBackground,
//             ),
//             textRendererStyle: TextRendererStyle.header2,
//           )
//         else
//           Text(
//             "Learn Math and Code",
//             style: context.textStyle.titleMdMedium.copyWith(
//               color: context.colorscheme.onBackground,
//             ),
//             textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//           ),
//
//         SizedBox(height: 8),
//
//         if (kIsWeb)
//           SEOText(
//             "Mobile app developer",
//             textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//             style: context.textStyle.bodyMdMedium.copyWith(
//               color: context.colorscheme.onSurface,
//             ),
//             textRendererStyle: TextRendererStyle.header3,
//           )
//         else
//           Text(
//             "Mobile app developer",
//             style: context.textStyle.bodyMdMedium.copyWith(
//               color: context.colorscheme.onSurface,
//             ),
//             textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
//           ),
//
//       ],
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video01_portfolio_website/extensions.dart';

class HeroTexts extends StatelessWidget {
  const HeroTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: context.isDesktopOrTablet
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          "Teacher's Guide",
          style: context.textStyle.titleSmBold.copyWith(
            color: context.colorscheme.onBackground,
          ),
          textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          "Learn Math and Code",
          style: context.textStyle.titleMdMedium.copyWith(
            color: context.colorscheme.onBackground,
          ),
          textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          "Mobile app developer",
          style: context.textStyle.bodyMdMedium.copyWith(
            color: context.colorscheme.onSurface,
          ),
          textAlign: context.isDesktopOrTablet ? TextAlign.left : TextAlign.center,
        ),
      ],
    );
  }
}
