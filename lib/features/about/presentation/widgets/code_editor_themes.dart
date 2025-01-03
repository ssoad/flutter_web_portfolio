import 'dart:ui';

class CodeEditorTheme {
  static const darkBackground = Color(0xFF1E1E1E);
  static const darkHeaderBg = Color(0xFF2D2D2D);
  static const lightBackground = Color(0xFFF3F3F3);
  static const lightHeaderBg = Color(0xFFE5E5E5);

  static const darkSyntax = {
    'comment': Color(0xFF608B4E),
    'keyword': Color(0xFF569CD6),
    'string': Color(0xFFCE9178),
    'normal': Color(0xFFD4D4D4),
    'lineNumber': Color(0xFF858585),
  };

  static const lightSyntax = {
    'comment': Color(0xFF008000),
    'keyword': Color(0xFF0000FF),
    'string': Color(0xFFA31515),
    'normal': Color(0xFF000000),
    'lineNumber': Color(0xFF737373),
  };
}