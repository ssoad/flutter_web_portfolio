class SkillModel {
  final String name;
  final double proficiency;
  final String category;
  final String icon;

  final String? description;

  SkillModel({
    required this.name,
    required this.proficiency,
    required this.category,
    required this.icon,
    this.description
  });
}