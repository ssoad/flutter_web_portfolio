import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';
import '../../../shared/utils/responsive_helper.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeProvider);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isDesktop) Expanded(child: Image.asset(homeData.imageUrl)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, I am',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  homeData.name,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  homeData.role,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(homeData.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}