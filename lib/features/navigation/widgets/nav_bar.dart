import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_experiment/config/constants.dart';
import '../../../shared/utils/responsive_helper.dart';
import 'dart:ui' as ui;

import '../providers/nav_provider.dart';

class NavigationBar extends ConsumerWidget {
  final Function(String) onNavItemTap;

  const NavigationBar({super.key, required this.onNavItemTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navItems = ref.watch(navigationItemsProvider);
    final selectedRoute = ref.watch(selectedNavItemProvider);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      margin: EdgeInsets.all(isDesktop ? 16 : 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 24 : 16,
              vertical: isDesktop ? 16 : 12,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Theme.of(context).primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogo(context, isDesktop),
                if (isDesktop)
                  Row(
                    children: navItems
                        .map((item) => _buildNavItem(
                              context,
                              item.name,
                              selectedRoute == item.route,
                              () {
                                ref
                                    .read(selectedNavItemProvider.notifier)
                                    .state = item.route;
                                onNavItemTap(item.route);
                              },
                            ))
                        .toList(),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _showMobileMenu(context, ref, navItems),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String name,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: (isSelected || isHovered)
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.2),
                          Theme.of(context).primaryColor.withOpacity(0.1),
                        ],
                      )
                    : null,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor.withOpacity(0.5)
                      : Colors.transparent,
                ),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : isHovered
                          ? Theme.of(context).primaryColor.withOpacity(0.8)
                          : null,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo(BuildContext context, bool isDesktop) {
    return ShaderMask(
      shaderCallback: (bounds) => ui.Gradient.linear(
        const Offset(0, 0),
        Offset(bounds.width, 0),
        [
          Theme.of(context).primaryColor,
          Theme.of(context).colorScheme.secondary,
        ],
      ),
      child: Text(
        AppConstants.name,
        style: TextStyle(
          fontSize: isDesktop ? 24 : 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showMobileMenu(
    BuildContext context,
    WidgetRef ref,
    List<NavigationItem> items,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) {
            final isSelected = ref.watch(selectedNavItemProvider) == item.route;
            return ListTile(
              title: Text(
                item.name,
                style: TextStyle(
                  color: isSelected ? Theme.of(context).primaryColor : null,
                  fontWeight: isSelected ? FontWeight.bold : null,
                ),
              ),
              onTap: () {
                ref.read(selectedNavItemProvider.notifier).state = item.route;
                onNavItemTap(item.route);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
