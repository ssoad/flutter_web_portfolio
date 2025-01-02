import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/home_model.dart';

final homeProvider = Provider<HomeModel>((ref) {
  return HomeModel(
    name: "Soad",
    role: "Flutter Developer",
    description:
        "A passionate Flutter developer with experience in building...",
    imageUrl: "assets/profile.png",
    socialLinks: [
      "https://github.com/ssoad",
      "https://linkedin.com/in/ssoad",
    ],
  );
});
