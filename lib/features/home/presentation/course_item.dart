
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video01_portfolio_website/extensions.dart';

import '../../../styles/app_size.dart';
import '../../../widgets/appbar/seo_text.dart';

import 'package:flutter/material.dart';
// Assuming your utility imports (SEOText, context extensions) are here

import 'package:flutter/material.dart';
// Assuming your utility imports (SEOText, context extensions, etc.) are here

class CourseItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool isMobile;
  final VoidCallback? onTap;

  const CourseItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.isMobile = false,
    this.onTap,
  });

  @override
  State<CourseItem> createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  // --- State Variables for Effects ---
  bool _isHovering = false;
  bool _isTappedDown = false; // New state for click/press effect

  // --- Dynamic Properties ---
  static const Duration _animationDuration = Duration(milliseconds: 200);

  // Scale factor: Smaller when pressed down
  double get _scale => _isTappedDown ? 0.98 : 1.0;

  // Elevation factor: Lower when pressed down
  double get _elevation => _isTappedDown ? 2.0 : (widget.isMobile ? 6.0 : 8.0);

  // --- Helper Methods ---

  // Manages the state when the user taps down
  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() {
        _isTappedDown = true;
      });
    }
  }

  // Manages the state when the user lifts tap or cancels
  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() {
        _isTappedDown = false;
      });
    }
  }

  // Manages the state when tap is complete (and triggers navigation)
  void _handleTap() {
    // Ensure the visual state is reset just before navigation
    setState(() {
      _isTappedDown = false;
    });
    widget.onTap?.call();
  }

  // Helper method for the static (mobile) card content
  Widget _buildCardContent(
      BuildContext context,
      double imageHeight,
      double fixedDescriptionHeight,
      double borderRadius,
      double titleFontSize,
      double descriptionFontSize,
      int descriptionMaxLines,
      ColorScheme colorScheme,
      TextStyle textStyleBodyLgBold) {

    // The Card now uses the dynamic elevation
    return Card(
      elevation: _elevation, // Dynamic elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      clipBehavior: Clip.antiAlias,

      // 💡 GestureDetector handles the press/tap down/up effects
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: () => setState(() => _isTappedDown = false),
        onTap: _handleTap, // Triggers the navigation callback

        // InkWell provides the visual ripple effect over the card
        child: InkWell(
          // onTap is null here because GestureDetector handles the overall click
          onTap: null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- IMAGE SECTION ---
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(borderRadius),
                  topLeft: Radius.circular(borderRadius),
                ),
                child: SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Image.network(
                    widget.imageUrl, // Accessing widget properties
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.1),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),

              // --- TEXT AREA ---
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    SEOText(
                      widget.title,
                      style: textStyleBodyLgBold.copyWith(
                        color: colorScheme.onBackground,
                        fontSize: titleFontSize,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Fixed Height Description Block
                    SizedBox(
                      height: fixedDescriptionHeight,
                      child: SEOText(
                        widget.description,
                        maxLines: descriptionMaxLines,
                        overflow: TextOverflow.ellipsis,
                        style: textStyleBodyLgBold.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.normal,
                          fontSize: descriptionFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for the interactive (desktop) card
  Widget _buildHoverCard(
      BuildContext context,
      Widget cardContent) {

    return MouseRegion(
      // Change cursor and manage hover state
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),

      // AnimatedContainer handles the press-down effect (scale) and potential hover effects
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.easeInOut,
        // Apply dynamic scale when pressed down
        transform: Matrix4.identity().scaled(_scale),
        alignment: Alignment.center,
        child: cardContent,
      ),
    );
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    // Determine sizing based on mode
    final double imageHeight = widget.isMobile ? 140 : 160;
    final double titleFontSize = widget.isMobile ? 16 : 18;
    final double descriptionFontSize = widget.isMobile ? 14 : 16;
    final int descriptionMaxLines = widget.isMobile ? 3 : 4;
    const double borderRadius = 12.0;

    // Pre-calculate fixed height for description text
    final double fixedDescriptionHeight =
        descriptionMaxLines * descriptionFontSize * 1.3;

    // Theme
    final colorScheme = context.colorscheme;
    final textStyleBodyLgBold = context.textStyle.bodyLgBold;

    // 1. Build the clickable card content first
    final cardWidget = _buildCardContent(
        context,
        imageHeight,
        fixedDescriptionHeight,
        borderRadius,
        titleFontSize,
        descriptionFontSize,
        descriptionMaxLines,
        colorScheme,
        textStyleBodyLgBold);

    // 2. Apply the hover/animation wrapper
    return widget.isMobile
        ? AnimatedContainer( // Apply scale animation for mobile as well
      duration: _animationDuration,
      curve: Curves.easeInOut,
      transform: Matrix4.identity().scaled(_scale),
      alignment: Alignment.center,
      child: cardWidget,
    )
        : _buildHoverCard(
      context,
      cardWidget,
    );
  }
}