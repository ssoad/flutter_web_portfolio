class ProjectModel {
  final String title;
  final String description;
  final String imageUrl;
  final String githubUrl;
  final String liveUrl;
  final List<String> technologies;
  final DateTime date;

  ProjectModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.githubUrl,
    required this.liveUrl,
    required this.technologies,
    required this.date,
  });
}