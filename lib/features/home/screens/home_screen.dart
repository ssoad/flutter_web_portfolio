import 'package:flutter/material.dart' hide NavigationBar;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../about/presentation/views/about_view.dart';
import '../../contact/view/contact_view.dart';
import '../../footer/widgets/footer_view.dart';
import '../../navigation/providers/nav_provider.dart';
import '../../navigation/widgets/nav_bar.dart';
import '../../projects/presentation/views/project_view.dart';
import '../../skills/views/skill_view.dart';
import '../widgets/hero_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    '/home': GlobalKey(),
    '/about': GlobalKey(),
    '/projects': GlobalKey(),
    '/skills': GlobalKey(),
    '/contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final scrollOffset = _scrollController.offset;
    final viewportHeight = MediaQuery.of(context).size.height;

    for (final entry in _sectionKeys.entries) {
      final key = entry.value;
      if (key.currentContext != null) {
        final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        final sectionTop = position.dy - viewportHeight * 0.2;

        if (scrollOffset >= sectionTop &&
            scrollOffset < sectionTop + box.size.height) {
          ref.read(selectedNavItemProvider.notifier).state = entry.key;
          break;
        }
      }
    }
  }

  Future<void> scrollToSection(String route) async {
    final key = _sectionKeys[route];
    if (key?.currentContext != null) {
      await Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavigationBar(onNavItemTap: scrollToSection),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(key: _sectionKeys['/home']),
                  AboutSection(key: _sectionKeys['/about']),
                  ProjectsSection(key: _sectionKeys['/projects']),
                  SkillsSection(key: _sectionKeys['/skills']),
                  ContactSection(key: _sectionKeys['/contact']),
                  const FooterView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}