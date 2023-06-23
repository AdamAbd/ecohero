import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(radius: 60),
              CircleAvatar(radius: 15, backgroundColor: Colors.amber),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Adam Abdurrahman',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Text(
            'adam@adam.com',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {},
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
