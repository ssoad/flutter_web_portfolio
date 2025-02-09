import 'package:flutter/material.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.05),
            Theme.of(context).colorScheme.secondary.withOpacity(0.05),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          // Main Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildBranding(context),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: _buildQuickLinks(context),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: _buildSocialLinks(context),
              ),
            ],
          ),
          const SizedBox(height: 48),

          // Divider with gradient
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                ],
              ),
            ),
          ),

          // Copyright
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© ${DateTime.now().year} Sheikh Soad',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                _buildHeartBeatAnimation(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBranding(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ).createShader(bounds),
          child: const Text(
            'SHEIKH SOAD',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Crafting digital experiences with Flutter magic ✨',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withOpacity(0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    final links = [
      ('Home', '#home'),
      ('About', '#about'),
      ('Projects', '#projects'),
      ('Contact', '#contact'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Quick Links'),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedHoverText(text: link.$1),
              ),
            )),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final socials = [
      ('GitHub', Icons.code, 'https://github.com/ssoad'),
      ('LinkedIn', Icons.work, 'https://linkedin.com/in/ssoad'),
      ('Twitter', Icons.flutter_dash, 'https://twitter.com/ssoad'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Connect'),
        const SizedBox(height: 16),
        ...socials.map((social) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    Icon(social.$2, size: 18),
                    const SizedBox(width: 8),
                    AnimatedHoverText(text: social.$1),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildHeartBeatAnimation(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Made with ',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        HeartbeatAnimation(
          child: Icon(
            Icons.favorite,
            color: Theme.of(context).primaryColor,
            size: 18,
          ),
        ),
        Text(
          ' using Flutter',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class AnimatedHoverText extends StatefulWidget {
  final String text;

  const AnimatedHoverText({super.key, required this.text});

  @override
  State<AnimatedHoverText> createState() => _AnimatedHoverTextState();
}

class _AnimatedHoverTextState extends State<AnimatedHoverText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: isHovered
              ? Theme.of(context).primaryColor
              : Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 14,
          fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
        ),
        child: Text(widget.text),
      ),
    );
  }
}

class HeartbeatAnimation extends StatefulWidget {
  final Widget child;

  const HeartbeatAnimation({super.key, required this.child});

  @override
  State<HeartbeatAnimation> createState() => _HeartbeatAnimationState();
}

class _HeartbeatAnimationState extends State<HeartbeatAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
