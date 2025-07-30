import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kebijakan Privasi")),
      body: const Center(child: Text("Halaman Kebijakan Privasi")),
    );
  }
}
