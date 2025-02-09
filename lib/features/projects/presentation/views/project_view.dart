import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/utils/responsive_helper.dart';
import '../../models/project_model.dart';
import '../../providers/project_provider.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends ConsumerStatefulWidget {
  const ProjectsSection({super.key});

  @override
  ConsumerState<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends ConsumerState<ProjectsSection> {
  String _selectedCategory = 'All';
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(projectsProvider);
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
          _buildCategoryFilter(context, projects),
          const SizedBox(height: 60),
          isDesktop
              ? _buildDesktopLayout(context, projects)
              : _buildMobileLayout(context, projects),
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
            'Featured Projects',
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

  Widget _buildCategoryFilter(
      BuildContext context, List<ProjectModel> projects) {
    final categories = ['All', ...projects.map((p) => p.category).toSet()];

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

  Widget _buildDesktopLayout(
      BuildContext context, List<ProjectModel> projects) {
    final filteredProjects = _selectedCategory == 'All'
        ? projects
        : projects.where((p) => p.category == _selectedCategory).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 1.2,
      ),
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) => _buildAnimatedProjectCard(
        context,
        filteredProjects[index],
        index,
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<ProjectModel> projects) {
    final filteredProjects = _selectedCategory == 'All'
        ? projects
        : projects.where((p) => p.category == _selectedCategory).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _buildAnimatedProjectCard(
          context,
          filteredProjects[index],
          index,
        ),
      ),
    );
  }

  Widget _buildAnimatedProjectCard(
      BuildContext context, ProjectModel project, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: ProjectCard(project: project),
          ),
        );
      },
    );
  }
}
