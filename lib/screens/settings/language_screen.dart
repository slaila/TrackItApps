import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bahasa")),
      body: const Center(child: Text("Halaman Bahasa")),
    );
  }
}
