import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/transaction_provider.dart';
import 'add_transaction_screen.dart';
import 'statistics_screen.dart';
import 'transaction_list_screen.dart';
import '../../widgets/saving_goal_card.dart';
import '../settings/account_setting_screen.dart'; // ✅ arahkan ke file settings yang benar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const TransactionListScreen(),
    const StatisticsScreen(),
    const AccountSettingsScreen(), // ✅ class dari file yang diimport
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TrackIT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF42A5F5),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF42A5F5),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Transaksi'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Statistik'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    const userName = "Hilman";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF90CAF9),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang, $userName 👋',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Ayo teruskan kebiasaan menabungmu hari ini!',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SavingGoalCard(
            currentAmount: transactionProvider.balance,
            goalAmount: 10000000,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF42A5F5), Color(0xFF64B5F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Saldo Anda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Rp${transactionProvider.balance.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.arrow_downward, color: Colors.greenAccent, size: 28),
                        const SizedBox(height: 4),
                        const Text('Pemasukan', style: TextStyle(color: Colors.white)),
                        Text(
                          'Rp${transactionProvider.totalIncomes.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.arrow_upward, color: Colors.redAccent, size: 28),
                        const SizedBox(height: 4),
                        const Text('Pengeluaran', style: TextStyle(color: Colors.white)),
                        Text(
                          'Rp${transactionProvider.totalExpenses.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
