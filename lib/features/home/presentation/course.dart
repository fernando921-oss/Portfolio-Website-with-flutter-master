// course.dart

class Course {
  final int id;
  final String imageUrl;
  final String title;
  final String description;
  final String youtubeUrl;
  final bool isPaid; // new flag

  const Course({

    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.youtubeUrl,
    this.isPaid = false, // default false

  });
}