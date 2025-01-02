import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_experiment/features/experience/presentation/widgets/timeline_item.dart';

import '../../../../shared/utils/responsive_helper.dart';
import '../widgets/experience_card.dart';
import '../widgets/timeline_dot.dart';

class ExperienceView extends ConsumerStatefulWidget {
  const ExperienceView({super.key});

  @override
  ConsumerState<ExperienceView> createState() => _ExperienceViewState();
}

class _ExperienceViewState extends ConsumerState<ExperienceView> {
  final ScrollController _scrollController = ScrollController();
  double _timelineProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateTimelineProgress);
  }

  void _updateTimelineProgress() {
    if (!_scrollController.hasClients) return;
    setState(() {
      _timelineProgress = (_scrollController.offset /
              _scrollController.position.maxScrollExtent)
          .clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Stack(
      children: [
        // Timeline Line
        Positioned(
          left: 120,
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
                stops: [_timelineProgress, _timelineProgress],
              ),
            ),
          ),
        ),
        // Experience Items
        Column(
          children: [
            _buildTimelineItem(
              alignment: TimelineAlign.left,
              company: "Senior Software Engineer",
              duration: "2022 - Present",
              description:
                  "Led development of multiple Flutter applications...",
              technologies: ["Flutter", "Dart", "Firebase"],
              index: 0,
            ),
            _buildTimelineItem(
              alignment: TimelineAlign.right,
              company: "Flutter Developer",
              duration: "2020 - 2022",
              description: "Developed cross-platform applications...",
              technologies: ["Flutter", "REST API", "SQL"],
              index: 1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required TimelineAlign alignment,
    required String company,
    required String duration,
    required String description,
    required List<String> technologies,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: alignment == TimelineAlign.left
            ? [
                Expanded(
                  child: _buildExperienceCard(
                    company: company,
                    duration: duration,
                    description: description,
                    technologies: technologies,
                  ),
                ),
                const SizedBox(width: 20),
                TimelineDot(
                  progress: _timelineProgress,
                  index: index,
                ),
                const Expanded(child: SizedBox()),
              ]
            : [
                const Expanded(child: SizedBox()),
                TimelineDot(
                  progress: _timelineProgress,
                  index: index,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildExperienceCard(
                    company: company,
                    duration: duration,
                    description: description,
                    technologies: technologies,
                  ),
                ),
              ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildExperienceCard(
            company: "Senior Software Engineer",
            duration: "2022 - Present",
            description: "Led development of multiple Flutter applications...",
            technologies: ["Flutter", "Dart", "Firebase"],
          ),
          const SizedBox(height: 20),
          _buildExperienceCard(
            company: "Flutter Developer",
            duration: "2020 - 2022",
            description: "Developed cross-platform applications...",
            technologies: ["Flutter", "REST API", "SQL"],
          ),
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
            'Experience',
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

  Widget _buildExperienceCard({
    required String company,
    required String duration,
    required String description,
    required List<String> technologies,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 200),
            tween: Tween<double>(begin: 1.0, end: isHovered ? 1.05 : 1.0),
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                      color: isHovered
                          ? Theme.of(context).primaryColor.withOpacity(0.5)
                          : Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        blurRadius: isHovered ? 20 : 10,
                        spreadRadius: isHovered ? 5 : 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            company,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2),
                                ],
                              ),
                            ),
                            child: Text(
                              duration,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                            ),
                            child: Text(tech),
                          );
                        }).toList(),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
