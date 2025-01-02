import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationItemsProvider = Provider<List<NavigationItem>>((ref) {
  return [
    const NavigationItem(name: "Home", route: "/home"),
    const NavigationItem(name: "About", route: "/about"),
    const NavigationItem(name: "Experience", route: "/experience"),
    const NavigationItem(name: "Projects", route: "/projects"),
    const NavigationItem(name: "Skills", route: "/skills"),
    const NavigationItem(name: "Contact", route: "/contact"),
  ];
});

final selectedNavItemProvider = StateProvider<String>((ref) => "/home");

class NavigationItem {
  final String name;
  final String route;

  const NavigationItem({required this.name, required this.route});
}
