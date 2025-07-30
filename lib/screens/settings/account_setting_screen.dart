import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'security_screen.dart';
import 'notification_screen.dart';
import 'language_screen.dart';
import 'help_screen.dart';
import 'privacy_policy_screen.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Akun'),
        automaticallyImplyLeading: false, // <-- menghapus tombol back
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: const Color(0xFFF3F7FC),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hilman Syachr',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'hilman@example.com',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Akun',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          _buildSettingTile(Icons.person, 'Profil', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
          _buildSettingTile(Icons.lock, 'Keamanan', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityScreen()));
          }),
          _buildSettingTile(Icons.notifications, 'Notifikasi', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
          }),
          _buildSettingTile(Icons.language, 'Bahasa', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageScreen()));
          }),
          const SizedBox(height: 24),
          const Text(
            'Lainnya',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          _buildSettingTile(Icons.help_outline, 'Bantuan', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpScreen()));
          }),
          _buildSettingTile(Icons.privacy_tip_outlined, 'Kebijakan Privasi', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
          }),
          _buildSettingTile(Icons.logout, 'Keluar', () {
            Navigator.pop(context);
          }, color: Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: color ?? const Color(0xFF1E88E5)),
        title: Text(title, style: TextStyle(color: color ?? Colors.black87)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
