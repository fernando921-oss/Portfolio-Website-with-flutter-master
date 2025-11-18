import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.6,
      child: Container( // Wrap with Container to add decoration
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(250)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Darker, slightly transparent shadow
              blurRadius: 20, // More blur for a softer shadow
              spreadRadius: 5, // A bit of spread to make it noticeable
              offset: Offset(0, 10), // Offset the shadow downwards
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(250)),
          child: Image.asset(
            'assets/images/me.jpg',
            fit: BoxFit.cover,
          ), // Image.asset
        ), // ClipRRect
      ), // Container
    );
  }
}