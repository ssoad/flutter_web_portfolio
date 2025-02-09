import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/utils/responsive_helper.dart';
import '../../../experience/models/about_model.dart';
import '../../../experience/presentation/widgets/education_card.dart';
import '../../../experience/providers/about_provider.dart';

class EducationSection extends ConsumerWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutData = ref.watch(aboutProvider);
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? size.width * 0.1 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 60),
          isDesktop
              ? _buildDesktopLayout(context, aboutData)
              : _buildMobileLayout(context, aboutData),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ).createShader(bounds),
          child: Text(
            'Education Journey',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AboutModel data) {
    return Stack(
      children: [
        Positioned(
          left: 20,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: data.education.asMap().entries.map((entry) {
            final index = entry.key;
            final edu = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 200)),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(50 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 30),
                      child: EducationCard(education: edu),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, AboutModel data) {
    return Column(
      children: data.education.asMap().entries.map((entry) {
        final index = entry.key;
        final edu = entry.value;
        return TweenAnimationBuilder(
          duration: Duration(milliseconds: 600 + (index * 200)),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: EducationCard(education: edu),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
