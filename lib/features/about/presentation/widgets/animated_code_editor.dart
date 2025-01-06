import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../widgets/code_editor_themes.dart';

class AnimatedCodeEditor extends StatefulWidget {
  final List<String> codeLines;

  const AnimatedCodeEditor({
    super.key,
    required this.codeLines,
  });

  @override
  State<AnimatedCodeEditor> createState() => _AnimatedCodeEditorState();
}

class _AnimatedCodeEditorState extends State<AnimatedCodeEditor> {
  late List<bool> _lineVisibility;
  int _currentLine = 0;

  @override
  void initState() {
    super.initState();
    _lineVisibility = List.filled(widget.codeLines.length, false);
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    for (int i = 0; i < widget.codeLines.length; i++) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) {
        setState(() {
          _lineVisibility[i] = true;
          _currentLine = i;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final syntax =
        isDark ? CodeEditorTheme.darkSyntax : CodeEditorTheme.lightSyntax;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
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
          _buildEditorHeader(context),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.codeLines.length,
                (index) => _buildCodeLine(
                  context: context,
                  line: widget.codeLines[index],
                  lineNumber: index + 1,
                  isVisible: _lineVisibility[index],
                  syntax: syntax,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE5E5E5),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          _buildWindowControls(),
          const SizedBox(width: 16),
          _buildFileTab(context),
        ],
      ),
    );
  }

  Widget _buildWindowControls() {
    return Row(
      children: [
        _buildWindowButton(Colors.red.shade400),
        const SizedBox(width: 8),
        _buildWindowButton(Colors.amber.shade400),
        const SizedBox(width: 8),
        _buildWindowButton(Colors.green.shade400),
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

  Widget _buildFileTab(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
    );
  }

  Widget _buildCodeLine({
    required BuildContext context,
    required String line,
    required int lineNumber,
    required bool isVisible,
    required Map<String, Color> syntax,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isVisible ? 1 : 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              lineNumber.toString(),
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[600]
                    : Colors.grey[400],
                fontFamily: 'FiraCode',
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: isVisible
                ? TypewriterAnimatedTextKit(
                    text: [line],
                    isRepeatingAnimation: false,
                    speed: const Duration(milliseconds: 50),
                    textStyle: TextStyle(
                      color: _getCodeColor(line, syntax),
                      fontFamily: 'FiraCode',
                      fontSize: 14,
                      height: 1.5,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Color _getCodeColor(String code, Map<String, Color> syntax) {
    if (code.startsWith('//')) return syntax['comment']!;
    if (code.contains('"')) return syntax['string']!;
    if (code.contains('class') ||
        code.contains('void') ||
        code.contains('final') ||
        code.contains('var')) {
      return syntax['keyword']!;
    }
    return syntax['normal']!;
  }
}
