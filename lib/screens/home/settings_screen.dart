import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: const Color(0xFFF3F7FC),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profil Pengguna
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

          // Daftar Menu Pengaturan
          const Text(
            'Akun',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          _buildSettingTile(Icons.person, 'Profil', () {}),
          _buildSettingTile(Icons.lock, 'Keamanan', () {}),
          _buildSettingTile(Icons.notifications, 'Notifikasi', () {}),
          _buildSettingTile(Icons.language, 'Bahasa', () {}),

          const SizedBox(height: 24),
          const Text(
            'Lainnya',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          _buildSettingTile(Icons.help_outline, 'Bantuan', () {}),
          _buildSettingTile(Icons.privacy_tip_outlined, 'Kebijakan Privasi', () {}),
          _buildSettingTile(Icons.logout, 'Keluar', () {
            // Tambahkan aksi logout di sini
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
