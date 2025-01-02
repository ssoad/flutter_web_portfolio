import 'package:flutter/material.dart';
import 'package:flutter_web_experiment/features/experience/presentation/views/experience_view.dart';

class TimelineItem extends StatefulWidget {
  final TimelineAlign alignment;
  final Widget timelineDot;
  final Widget card;

  const TimelineItem({
    super.key,
    required this.alignment,
    required this.timelineDot,
    required this.card,
  });

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _isVisible ? 1.0 : 0.0,
      child: Row(
        children: widget.alignment == TimelineAlign.left
            ? [
                Expanded(child: widget.card),
                const SizedBox(width: 20),
                widget.timelineDot,
                const Expanded(child: SizedBox()),
              ]
            : [
                const Expanded(child: SizedBox()),
                widget.timelineDot,
                const SizedBox(width: 20),
                Expanded(child: widget.card),
              ],
      ),
    );
  }
}

enum TimelineAlign { left, right }