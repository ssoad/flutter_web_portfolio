class ProjectModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String githubUrl;
  final String liveUrl;
  final List<String> technologies;
  final List<String> features;
  final DateTime date;
  final String category;
  final ProjectStatus status;
  final ProjectType type;
  final String role;
  final ProjectMetrics metrics;
  final List<String> achievements;
  final Duration duration;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.githubUrl,
    required this.liveUrl,
    required this.technologies,
    required this.features,
    required this.date,
    required this.category,
    this.status = ProjectStatus.completed,
    this.type = ProjectType.personal,
    this.role = 'Lead Developer',
    required this.metrics,
    this.achievements = const [],
    required this.duration,
  });
}

class ProjectMetrics {
  final int stars;
  final int forks;
  final String downloads;
  final int commits;
  final int contributors;

  ProjectMetrics({
    this.stars = 0,
    this.forks = 0,
    this.downloads = '0',
    this.commits = 0,
    this.contributors = 1,
  });
}

enum ProjectStatus {
  inProgress,
  completed,
  maintenance
}

enum ProjectType {
  personal,
  client,
  openSource,
  research
}