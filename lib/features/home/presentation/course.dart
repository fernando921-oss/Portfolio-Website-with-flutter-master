import 'package:video01_portfolio_website/features/home/presentation/video.dart';

class Course {
  final int id;

  final String titleEn;
  final String titleSi;

  final String descriptionEn;
  final String descriptionSi;

  final String imageUrl;
  final String youtubeUrl;

  final List<Videos> videos;

  Course({
    required this.id,
    required this.titleEn,
    required this.titleSi,
    required this.descriptionEn,
    required this.descriptionSi,
    required this.imageUrl,
    required this.youtubeUrl,
    required this.videos,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_en': titleEn,
      'title_si': titleSi,
      'description_en': descriptionEn,
      'description_si': descriptionSi,
      'imageUrl': imageUrl,
      'youtubeUrl': youtubeUrl,
    };
  }
}

