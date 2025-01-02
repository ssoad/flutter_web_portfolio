import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/about_model.dart';
import '../../providers/about_provider.dart';
import '../../../../shared/utils/responsive_helper.dart';
import '../widgets/education_card.dart';
import '../widgets/experience_card.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutData = ref.watch(aboutProvider);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          Text(aboutData.bio),
          const SizedBox(height: 40),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(child: _buildExperience(context, aboutData)),
                // const SizedBox(width: 40),
                // Expanded(child: _buildEducation(context, aboutData)),
              ],
            )
          else
            Column(
              children: [
                // _buildExperience(context, aboutData),
                // const SizedBox(height: 40),
                // _buildEducation(context, aboutData),
              ],
            ),
        ],
      ),
    );
  }

  // Widget _buildExperience(BuildContext context, AboutModel data) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Experience',
  //         style: Theme.of(context).textTheme.headlineMedium,
  //       ),
  //       const SizedBox(height: 20),
  //       ...data.experiences.map((exp) => ExperienceCard(experience: exp)),
  //     ],
  //   );
  // }

  // Widget _buildEducation(BuildContext context, AboutModel data) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Education',
  //         style: Theme.of(context).textTheme.headlineMedium,
  //       ),
  //       const SizedBox(height: 20),
  //       ...data.education.map((edu) => EducationCard(education: edu)),
  //     ],
  //   );
  // }
}
