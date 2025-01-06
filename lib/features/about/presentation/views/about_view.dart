import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_experiment/features/about/presentation/widgets/animated_code_editor.dart';

import '../../../../config/constants.dart';
import '../../../../shared/utils/responsive_helper.dart';
import '../widgets/code_editor.dart';
import '../widgets/code_editor_themes.dart';

class AboutView extends ConsumerWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 60),
          isDesktop
              ? _buildDesktopLayout(context)
              : _buildMobileLayout(context),
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
            'About Me',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
          ),
        ),
        const SizedBox(height: 16),
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Transform.scale(
              scaleX: value,
              child: Container(
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
            );
          },
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        // Full width code editor
        SizedBox(
          width: size.width * 0.5,
          child: _buildCodeEditor(context),
        ),
        const SizedBox(height: 60),
        // Two column layout
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile card with hover effect
              // Expanded(
              //   flex: 4,
              //   child: TweenAnimationBuilder(
              //     duration: const Duration(milliseconds: 200),
              //     tween: Tween<double>(begin: 0, end: 1),
              //     builder: (context, double value, child) {
              //       return Transform.translate(
              //         offset: Offset(0, 20 * (1 - value)),
              //         child: Opacity(
              //           opacity: value,
              //           child: _buildProfileCard(context),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(width: 60),
              // Achievements timeline
              Expanded(
                flex: 6,
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 200),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: _buildAchievementsTimeline(context),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // _buildProfileCard(context),
        // const SizedBox(height: 40),
        _buildAchievementsTimeline(context),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return StatefulBuilder(
      builder: (context, setState) {
        bool isCardHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isCardHovered = true),
          onExit: (_) => setState(() => isCardHovered = false),
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 200),
            tween: Tween<double>(begin: 1.0, end: isCardHovered ? 1.02 : 1.0),
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isDesktop ? 32 : 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).cardColor,
                        Theme.of(context).cardColor.withOpacity(0.8),
                      ],
                    ),
                    border: Border.all(
                      color: isCardHovered
                          ? Theme.of(context).primaryColor.withOpacity(0.5)
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        blurRadius: isCardHovered ? 20 : 10,
                        spreadRadius: isCardHovered ? 5 : 0,
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = (constraints.maxWidth - 60) / 2;
                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildStatItem(context, "Years of Experience",
                              "${AppConstants.yearsOfExperience}+", itemWidth),
                          _buildStatItem(context, "Projects Delivered",
                              "${AppConstants.projectsCompleted}+", itemWidth),
                          _buildStatItem(context, "Client Satisfaction", "100%",
                              itemWidth),
                          _buildStatItem(
                              context, "Code Coverage", "95%", itemWidth),
                          _buildStatItem(
                              context, "Apps Published", "15+", itemWidth),
                          _buildStatItem(
                              context, "Tech Stack", "Flutter/Dart", itemWidth),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
      BuildContext context, String label, String value, double width) {
    bool isItemHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isItemHovered = true),
          onExit: (_) => setState(() => isItemHovered = false),
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 200),
            tween: Tween<double>(begin: 1.0, end: isItemHovered ? 1.05 : 1.0),
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: width,
                  height: width * 0.7,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context)
                        .primaryColor
                        .withOpacity(isItemHovered ? 0.15 : 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .primaryColor
                            .withOpacity(isItemHovered ? 0.2 : 0.0),
                        blurRadius: isItemHovered ? 8 : 0,
                        spreadRadius: isItemHovered ? 2 : 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        child: Text(
                          label,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAchievementsTimeline(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Career Highlights',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        if (isDesktop)
          // Desktop Layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildProfileCard(context)),
              const SizedBox(width: 60),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    ...AppConstants.careerHighlights.map(
                      (highlight) => _buildHighlightCard(context, highlight),
                    ),
                  ],
                ),
              ),
            ],
          )
        else
          // Mobile Layout
          Column(
            children: [
              _buildProfileCard(context),
              const SizedBox(height: 32),
              ...AppConstants.careerHighlights.map(
                (highlight) => _buildHighlightCard(context, highlight),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildCodeEditor(BuildContext context) {
    return const AnimatedCodeEditor(
      codeLines: [
        'class AboutMe {',
        '  String name = "Sheikh Soad";',
        '  String title = "Flutter Developer";',
        '  String location = "Dhaka, Bangladesh";',
        '  String email = "mdsoad@gmail.com";',
        '  String github = "ssoad";',
        '  String linkedin = "ssoad";',
        '  String facebook = "sssoad";',
        '}',
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightCard(BuildContext context, String highlight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              highlight,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class StatItem {
  final String label;
  final String value;

  StatItem(this.label, this.value);
}
