import 'package:flutter/src/widgets/framework.dart';

class ProjectModel {
  final String title;
  final String description;
  final String imageUrl;
  final String githubUrl;
  final String liveUrl;
  final List<String> technologies;
  final DateTime date;

  final String category;

  ProjectModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.githubUrl,
    required this.liveUrl,
    required this.technologies,
    required this.date,
    required this.category,
  });
}
