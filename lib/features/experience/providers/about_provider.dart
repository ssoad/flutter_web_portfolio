import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/about_model.dart';

final aboutProvider = Provider<AboutModel>((ref) {
  return AboutModel(
    bio: "I am a passionate Flutter developer with 3+ years of experience...",
    experiences: [
      Experience(
        company: "Company Name",
        position: "Senior Flutter Developer",
        duration: "2021 - Present",
        description: "Leading development of multiple Flutter applications...",
      ),
    ],
    education: [
      Education(
        institution: "University Name",
        degree: "Bachelor in Computer Science",
        duration: "2017 - 2021",
        description: "Major in Software Engineering",
      ),
    ],
  );
});