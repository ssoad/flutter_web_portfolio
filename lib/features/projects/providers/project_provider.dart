import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_model.dart';

final projectsProvider = Provider<List<ProjectModel>>((ref) {
  return [
    ProjectModel(
      title: "Flutter Portfolio",
      description: "A responsive portfolio website built with Flutter Web",
      imageUrl: "assets/projects/portfolio.png",
      githubUrl: "https://github.com/ssoad/portfolio",
      liveUrl: "https://ssoad.dev",
      technologies: ["Flutter", "Dart", "Riverpod", "Firebase"],
      date: DateTime.now(),
    ),
    // Add more projects...
  ];
});