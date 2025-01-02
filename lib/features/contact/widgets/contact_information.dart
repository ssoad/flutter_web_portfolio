import 'package:flutter/material.dart';

import 'contact_info_item.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's talk about everything!",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),
        const Text(
          "Feel free to get in touch with me. I am always open to discussing new projects, creative ideas or opportunities to be part of your visions.",
        ),
        const SizedBox(height: 40),
        const ContactInfoItem(
          icon: Icons.email,
          title: 'Mail me at',
          content: 'contact@yourdomain.com',
        ),
        const SizedBox(height: 20),
        const ContactInfoItem(
          icon: Icons.phone,
          title: 'Call me at',
          content: '+880 1234567890',
        ),
      ],
    );
  }
}