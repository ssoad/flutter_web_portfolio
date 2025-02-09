import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import '../models/skill_model.dart';

class SkillCard extends StatefulWidget {
  final SkillModel skill;
  const SkillCard({super.key, required this.skill});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(_isHovered ? 0.2 : 0),
                blurRadius: 12,
                spreadRadius: _isHovered ? 2 : 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Theme.of(context)
                    //         .primaryColor
                    //         .withOpacity(_isHovered ? 0.2 : 0.1),
                    //     Theme.of(context)
                    //         .colorScheme
                    //         .secondary
                    //         .withOpacity(_isHovered ? 0.2 : 0.1),
                    //   ],
                    // ),
                    // borderRadius: BorderRadius.circular(12),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Theme.of(context)
                    //         .primaryColor
                    //         .withOpacity(_isHovered ? 0.3 : 0),
                    //     blurRadius: 8,
                    //     spreadRadius: _isHovered ? 2 : 0,
                    //   ),
                    // ],
                    ),
                child: Iconify(
                  widget.skill.icon,
                  size: 28,
                  // color: _isHovered ? null : Theme.of(context).iconTheme.color,
                ),
              ),
              const SizedBox(height: 8),
              FittedBox(
                child: Text(
                  widget.skill.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _isHovered
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.titleSmall?.color,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
