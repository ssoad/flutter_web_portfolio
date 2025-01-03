import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants.dart';
import '../../../../shared/utils/responsive_helper.dart';
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
    return Column(
      children: [
        _buildCodeEditor(context),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: _buildProfileCard(context),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 8,
              child: _buildAchievementsTimeline(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfileCard(context),
        const SizedBox(height: 40),
        _buildAchievementsTimeline(context),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.05),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.shortBio,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.8,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(height: 24),
          _buildStatCard(
            context,
            "Years of Experience",
            "${AppConstants.yearsOfExperience}+",
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            context,
            "Projects Completed",
            "${AppConstants.projectsCompleted}+",
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTimeline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Career Highlights',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 32),
        ...AppConstants.careerHighlights.map(
          (highlight) => _buildHighlightCard(context, highlight),
        ),
      ],
    );
  }

  Widget _buildCodeEditor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final syntax =
        isDark ? CodeEditorTheme.darkSyntax : CodeEditorTheme.lightSyntax;
    final backgroundColor = isDark
        ? CodeEditorTheme.darkBackground
        : CodeEditorTheme.lightBackground;
    final headerColor =
        isDark ? CodeEditorTheme.darkHeaderBg : CodeEditorTheme.lightHeaderBg;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: _buildEditorHeader(context),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeLine(context, 'class AboutMe {', 1, syntax),
                _buildCodeLine(
                    context, '  String name = "Sheikh Soad";', 2, syntax),
                _buildCodeLine(context, '  String title = "Flutter Developer";',
                    3, syntax),
                _buildCodeLine(context,
                    '  String location = "Dhaka, Bangladesh";', 4, syntax),
                _buildCodeLine(
                    context, '  String email = "mdsoad@gmail.com";', 5, syntax),
                _buildCodeLine(
                    context, '  String github = "ssoad";', 6, syntax),
                _buildCodeLine(
                    context, '  String linkedin = "ssoad";', 7, syntax),
                _buildCodeLine(
                    context, '  String facebook = "sssoad";', 8, syntax),
                _buildCodeLine(context, '}', 9, syntax),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorHeader(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        // Window Controls
        Row(
          children: [
            _buildWindowButton(Colors.red.shade400),
            const SizedBox(width: 8),
            _buildWindowButton(Colors.amber.shade400),
            const SizedBox(width: 8),
            _buildWindowButton(Colors.green.shade400),
          ],
        ),
        const SizedBox(width: 16),
        // File Tab
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                Icons.code,
                size: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                'about_me.dart',
                style: TextStyle(
                  fontFamily: 'FiraCode',
                  fontSize: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWindowButton(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 0.5,
        ),
      ),
    );
  }

  Widget _buildCodeLine(BuildContext context, String code, int lineNumber,
      Map<String, Color> syntax) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              lineNumber.toString(),
              style: TextStyle(
                color: syntax['lineNumber'],
                fontFamily: 'FiraCode',
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              code,
              style: TextStyle(
                color: code.startsWith('//')
                    ? syntax['comment']
                    : code.contains('"')
                        ? syntax['string']
                        : syntax['normal'],
                fontFamily: 'FiraCode',
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
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
