import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> expenses;
  final List<Transaction> incomes;

  const Chart({
    super.key,
    required this.expenses,
    required this.incomes,
  });

  double _getTotal(List<Transaction> transactions) {
    return transactions.fold(0.0, (sum, tx) => sum + tx.amount);
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = _getTotal(incomes);
    final totalExpense = _getTotal(expenses);
    final total = totalIncome + totalExpense;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Card for Pie Chart
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              children: [
                const Text(
                  "Statistik Bulanan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                const SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 1.3,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 50,
                      startDegreeOffset: -90,
                      sections: [
                        PieChartSectionData(
                          value: totalIncome,
                          color: Colors.green,
                          title: total > 0
                              ? '${((totalIncome / total) * 100).toStringAsFixed(1)}%'
                              : '0%',
                          radius: 60,
                          titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        PieChartSectionData(
                          value: totalExpense,
                          color: Colors.redAccent,
                          title: total > 0
                              ? '${((totalExpense / total) * 100).toStringAsFixed(1)}%'
                              : '0%',
                          radius: 60,
                          titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegend(Colors.green, "Pemasukan", totalIncome),
                    _buildLegend(Colors.redAccent, "Pengeluaran", totalExpense),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Card for Bar Chart
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Perbandingan Grafik Batang",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                ),
                const SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 1.5,
                  child: BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.black87,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              'Rp${rod.toY.toStringAsFixed(0)}',
                              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(
                            toY: totalIncome,
                            color: Colors.green,
                            width: 30,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(
                            toY: totalExpense,
                            color: Colors.redAccent,
                            width: 30,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ]),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              switch (value.toInt()) {
                                case 0:
                                  return const Text("Pemasukan");
                                case 1:
                                  return const Text("Pengeluaran");
                                default:
                                  return const Text("");
                              }
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: false),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: (totalIncome > totalExpense
                              ? totalIncome
                              : totalExpense) *
                          1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String label, double amount) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
