import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/skill_model.dart';

final skillsProvider = Provider<List<SkillModel>>((ref) {
  return [
    SkillModel(
      name: "Flutter",
      proficiency: 0.9,
      category: "Mobile Development",
      icon: Logos.flutter,
    ),
    SkillModel(
      name: "Firebase",
      proficiency: 0.85,
      category: "Backend",
      icon: Logos.firebase,
    ),
    SkillModel(
      name: "Dart",
      proficiency: 0.9,
      category: "Programming Language",
      icon: Logos.dart,
    ),
    SkillModel(
      name: "Git",
      proficiency: 0.8,
      category: "Version Control",
      icon: Logos.git,
    ),
    SkillModel(
      name: "HTML",
      proficiency: 0.9,
      category: "Web Development",
      icon: Logos.html_5,
    ),
    SkillModel(
      name: "CSS",
      proficiency: 0.85,
      category: "Web Development",
      icon: Logos.css_3,
    ),
    SkillModel(
      name: "JavaScript",
      proficiency: 0.8,
      category: "Programming Language",
      icon: Logos.javascript,
    ),
    SkillModel(
      name: "React",
      proficiency: 0.7,
      category: "Web Development",
      icon: Logos.react,
    ),
    SkillModel(
      name: "Node.js",
      proficiency: 0.6,
      category: "Backend",
      icon: Logos.nodejs,
    ),
    SkillModel(
      name: "MongoDB",
      proficiency: 0.6,
      category: "Database",
      icon: Logos.mongodb,
    ),
    // AI/ML
    SkillModel(
      name: "TensorFlow",
      proficiency: 0.6,
      category: "AI/ML",
      icon: Logos.tensorflow,
    ),
    SkillModel(
      name: "Python",
      proficiency: 0.8,
      category: "Programming Language",
      icon: Logos.python,
    ),

    // Backend
    SkillModel(
      name: "Django",
      proficiency: 0.75,
      category: "Backend",
      icon: Logos.django,
    ),
    SkillModel(
      name: "PostgreSQL",
      proficiency: 0.8,
      category: "Database",
      icon: Logos.postgresql,
    ),

    // Add more skills...
  ];
});
