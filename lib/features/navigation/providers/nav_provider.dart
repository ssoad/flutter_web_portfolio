import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationItemsProvider = Provider<List<NavigationItem>>((ref) {
  return [
    NavigationItem(name: "Home", route: "/home"),
    NavigationItem(name: "About", route: "/about"),
    NavigationItem(name: "Projects", route: "/projects"),
    NavigationItem(name: "Skills", route: "/skills"),
    NavigationItem(name: "Contact", route: "/contact"),
  ];
});

final selectedNavItemProvider = StateProvider<String>((ref) => "/home");

class NavigationItem {
  final String name;
  final String route;

  const NavigationItem({required this.name, required this.route});
}
