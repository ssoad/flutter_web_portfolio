import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_experiment/config/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared/utils/responsive_helper.dart';

class HeroSection extends ConsumerStatefulWidget {
  const HeroSection({super.key});

  @override
  ConsumerState<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends ConsumerState<HeroSection> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isDesktop)
            Expanded(
              child: Image.asset(
                'assets/images/profile.png',
                height: 400,
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, I am',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.name,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Flutter Developer',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'I build beautiful and functional mobile & web applications using Flutter.',
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    _buildSocialIcon(
                        FontAwesomeIcons.github, 'https://github.com/ssoad'),
                    _buildSocialIcon(FontAwesomeIcons.linkedin,
                        'https://linkedin.com/in/ssoad'),
                    _buildSocialIcon(FontAwesomeIcons.facebook,
                        'https://facebook.com/ssoad'),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Download CV'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        icon: FaIcon(icon),
        onPressed: () {},
        iconSize: 24,
      ),
    );
  }
}
