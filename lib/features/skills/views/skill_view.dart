import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/utils/responsive_helper.dart';
import '../models/skill_model.dart';
import '../providers/skill_provider.dart';
import '../widgets/skill_card.dart';

class SkillsSection extends ConsumerStatefulWidget {
  const SkillsSection({super.key});

  @override
  ConsumerState<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends ConsumerState<SkillsSection> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'All';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (!_scrollController.hasClients) return;
    setState(() {
      _progress = (_scrollController.offset /
              _scrollController.position.maxScrollExtent)
          .clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(skillsProvider);
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
          const SizedBox(height: 40),
          _buildCategoryFilter(context, skills),
          const SizedBox(height: 40),
          isDesktop
              ? _buildDesktopLayout(context, skills)
              : _buildMobileLayout(context, skills),
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
            'Skills & Expertise',
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
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(BuildContext context, List<SkillModel> skills) {
    final categories = ['All', ...skills.map((s) => s.category).toSet()];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 200),
                tween: Tween<double>(begin: 0, end: isSelected ? 1.0 : 0.0),
                builder: (context, double value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(value),
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(value),
                        ],
                      ),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.1 * value),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () =>
                            setState(() => _selectedCategory = category),
                        borderRadius: BorderRadius.circular(30),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, List<SkillModel> skills) {
    final filteredSkills = _selectedCategory == 'All'
        ? skills
        : skills.where((s) => s.category == _selectedCategory).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10, // Increased from 3
        childAspectRatio: 1.0, // Square aspect ratio for icon + text
        crossAxisSpacing: 16, // Reduced spacing
        mainAxisSpacing: 16,
      ),
      itemCount: filteredSkills.length,
      itemBuilder: (context, index) =>
          _buildAnimatedSkillItem(context, filteredSkills[index], index),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<SkillModel> skills) {
    final filteredSkills = _selectedCategory == 'All'
        ? skills
        : skills.where((s) => s.category == _selectedCategory).toList();

    return SingleChildScrollView(
      controller: _scrollController,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 3 items per row for mobile
          childAspectRatio: 1.0,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: filteredSkills.length,
        itemBuilder: (context, index) =>
            _buildAnimatedSkillItem(context, filteredSkills[index], index),
      ),
    );
  }

  Widget _buildAnimatedSkillItem(
      BuildContext context, SkillModel skill, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: SkillCard(skill: skill),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
