import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/skill_model.dart';

final skillsProvider = Provider<List<SkillModel>>((ref) {
  return [
    SkillModel(
      name: "Flutter",
      proficiency: 0.9,
      category: "Mobile Development",
      icon: "assets/icons/flutter.png",
    ),
    SkillModel(
      name: "Firebase",
      proficiency: 0.85,
      category: "Backend",
      icon: "assets/icons/firebase.png",
    ),
    // Add more skills...
  ];
});