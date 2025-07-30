import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/transaction_provider.dart';
import '../../widgets/chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Statistik Bulan Ini',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 16),
                  Chart(
                    expenses: transactionProvider.expenses,
                    incomes: transactionProvider.incomes,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Ringkasan Keuangan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Total Pemasukan:', 'Rp${transactionProvider.totalIncomes.toStringAsFixed(2)}', Colors.green),
                  _buildSummaryRow('Total Pengeluaran:', 'Rp${transactionProvider.totalExpenses.toStringAsFixed(2)}', Colors.red),
                  _buildSummaryRow('Saldo:', 'Rp${transactionProvider.balance.toStringAsFixed(2)}', Colors.blueAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
