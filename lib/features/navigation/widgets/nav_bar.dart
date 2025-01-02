import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nav_provider.dart';

class NavigationBar extends ConsumerWidget {
  final Function(String) onNavItemTap;

  const NavigationBar({
    super.key,
    required this.onNavItemTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navItems = ref.watch(navigationItemsProvider);
    final selectedRoute = ref.watch(selectedNavItemProvider);

    return Row(
      children: navItems.map((item) => NavigationItem(
        name: item.name,
        isSelected: selectedRoute == item.route,
        onTap: () {
          ref.read(selectedNavItemProvider.notifier).state = item.route;
          onNavItemTap(item.route);
        },
      )).toList(),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          name,
          style: TextStyle(
            color: isSelected ? Theme.of(context).primaryColor : null,
            fontWeight: isSelected ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }
}