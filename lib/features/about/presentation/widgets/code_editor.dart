import 'package:flutter/material.dart';
import '../widgets/code_editor_themes.dart';

class CodeEditor extends StatelessWidget {
  final List<String> codeLines;

  const CodeEditor({
    super.key,
    required this.codeLines,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final syntax =
        isDark ? CodeEditorTheme.darkSyntax : CodeEditorTheme.lightSyntax;
    final backgroundColor = isDark
        ? CodeEditorTheme.darkBackground
        : CodeEditorTheme.lightBackground;
    final headerColor =
        isDark ? CodeEditorTheme.darkHeaderBg : CodeEditorTheme.lightHeaderBg;

    return Container(
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
          _buildHeader(context, headerColor),
          _buildCodeContent(context, syntax),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color headerColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: _buildEditorControls(context),
    );
  }

  Widget _buildEditorControls(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.code,
                  size: 16,
                  color: isDark ? Colors.grey[400] : Colors.grey[600]),
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

  Widget _buildCodeContent(BuildContext context, Map<String, Color> syntax) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < codeLines.length; i++)
            _buildCodeLine(context, codeLines[i], i + 1, syntax),
        ],
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
                color: _getCodeColor(code, syntax),
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

  Color _getCodeColor(String code, Map<String, Color> syntax) {
    if (code.startsWith('//')) return syntax['comment']!;
    if (code.contains('"')) return syntax['string']!;
    if (code.contains('class') || code.contains('void'))
      return syntax['keyword']!;
    return syntax['normal']!;
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
}
