import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/utils/responsive_helper.dart';
import '../../../config/constants.dart';
import '../../../shared/widgets/custom_image.dart';
import 'social_icon,dart';

class HeroSection extends ConsumerStatefulWidget {
  const HeroSection({super.key});

  @override
  ConsumerState<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends ConsumerState<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildParticleBackground(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildParticleBackground() {
    return CustomPaint(
      painter: ParticlePainter(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Container(),
    );
  }

  Widget _buildMainContent() {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? size.width * 0.1 : 20,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: isDesktop
                    ? _buildDesktopLayout(size)
                    : _buildMobileLayout(size),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.translate(
              offset: Offset(_slideAnimation.value, 0),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: _buildProfileImage(size.height * 0.6),
              ),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          flex: 7,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.translate(
              offset: Offset(-_slideAnimation.value, 0),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: _buildContent(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(double maxHeight) {
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
                    constraints: BoxConstraints(
                      maxHeight: maxHeight,
                      maxWidth: maxHeight,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          blurRadius: isHovered ? 20 : 10,
                          spreadRadius: isHovered ? 5 : 0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomImage(
                        imagePath: AppConstants.profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ));
      },
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAnimatedText('Hello, I am'),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ).createShader(bounds),
          child: Text(
            AppConstants.name,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 16),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              AppConstants.role,
              textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          isRepeatingAnimation: false,
        ),
        const SizedBox(height: 24),
        Text(
          AppConstants.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        const Row(
          children: [
            SocialIcon(
              icon: FontAwesomeIcons.github,
              url: AppConstants.github,
            ),
            SizedBox(width: 16),
            SocialIcon(
              icon: FontAwesomeIcons.linkedin,
              url: AppConstants.linkedin,
            ),
            SizedBox(width: 16),
            SocialIcon(
              icon: FontAwesomeIcons.facebook,
              url: AppConstants.facebook,
            ),
          ],
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            // Navigate to CV
            launchUrl(Uri.parse(AppConstants.cv));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text('Download CV'),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(Size size) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.05),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: SizedBox(
                  height: size.height * 0.3,
                  child: _buildProfileImage(size.height * 0.25),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildContent(),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }

  Widget _buildAnimatedText(String text) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            letterSpacing: 1.2,
          ),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            text,
            speed: const Duration(milliseconds: 300),
            cursor: '_',
            curve: Curves.easeOut,
            // Keep text visible after animation
            textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  letterSpacing: 1.2,
                ),
          ),
        ],
        isRepeatingAnimation: false,
        displayFullTextOnTap: true,
        stopPauseOnTap: true,
        // Add long pause duration to keep text visible
        pause: const Duration(days: 365),
        // Ensure text remains visible after animation
        onFinished: () {
          setState(() {
            // Text will remain visible
          });
        },
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final Color color;
  final List<Particle> particles = List.generate(50, (index) => Particle());

  ParticlePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    for (var particle in particles) {
      particle.update(size);
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  double x = Random().nextDouble() * 400;
  double y = Random().nextDouble() * 800;
  double radius = Random().nextDouble() * 3 + 1;
  double speedX = Random().nextDouble() * 2 - 1;
  double speedY = Random().nextDouble() * 2 - 1;

  void update(Size size) {
    x += speedX;
    y += speedY;

    if (x < 0 || x > size.width) speedX *= -1;
    if (y < 0 || y > size.height) speedY *= -1;
  }
}
