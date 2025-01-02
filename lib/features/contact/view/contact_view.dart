import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/utils/responsive_helper.dart';
import '../widgets/contact_form.dart';
import '../widgets/contact_information.dart';

class ContactSection extends ConsumerWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get In Touch',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: ContactInformation()),
                const SizedBox(width: 40),
                Expanded(child: ContactForm()),
              ],
            )
          else
            Column(
              children: [
                const ContactInformation(),
                const SizedBox(height: 40),
                ContactForm(),
              ],
            ),
        ],
      ),
    );
  }
}
