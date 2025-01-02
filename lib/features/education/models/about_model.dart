class AboutModel {
  final String bio;
  final List<Experience> experiences;
  final List<Education> education;

  AboutModel({
    required this.bio,
    required this.experiences,
    required this.education,
  });
}

class Experience {
  final String company;
  final String position;
  final String duration;
  final String description;

  Experience({
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
  });
}

class Education {
  final String institution;
  final String degree;
  final String duration;
  final String description;

  Education({
    required this.institution,
    required this.degree,
    required this.duration,
    required this.description,
  });
}