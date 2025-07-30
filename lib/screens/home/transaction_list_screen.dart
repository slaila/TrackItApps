// Updated Transaction List Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.dart';
import '../../providers/transaction_provider.dart';
import '../../widgets/transaction_card.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      body: transactionProvider.transactions.isEmpty
          ? const Center(
              child: Text('Belum ada transaksi.\nTekan + untuk menambahkan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: transactionProvider.transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactionProvider.transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: TransactionCard(
                    transaction: transaction,
                    onDelete: () {
                      transactionProvider.deleteTransaction(transaction.id);
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTransactionScreen(transaction: transaction),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class EditTransactionScreen extends StatefulWidget {
  final Transaction transaction;

  const EditTransactionScreen({super.key, required this.transaction});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  late DateTime _selectedDate;
  late TransactionType _selectedType;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.transaction.title;
    _amountController.text = widget.transaction.amount.toString();
    _noteController.text = widget.transaction.note ?? '';
    _selectedDate = widget.transaction.date;
    _selectedType = widget.transaction.type;
    _selectedCategory = widget.transaction.category;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaksi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<TransactionType>(
                value: _selectedType,
                items: TransactionType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type == TransactionType.income ? 'Pemasukan' : 'Pengeluaran'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: const InputDecoration(labelText: 'Jenis Transaksi'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (value) => value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Jumlah tidak boleh kosong';
                  if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: const [
                  DropdownMenuItem(value: 'Makanan', child: Text('Makanan')),
                  DropdownMenuItem(value: 'Transportasi', child: Text('Transportasi')),
                  DropdownMenuItem(value: 'Hiburan', child: Text('Hiburan')),
                  DropdownMenuItem(value: 'Pendidikan', child: Text('Pendidikan')),
                  DropdownMenuItem(value: 'Tabungan', child: Text('Tabungan')),
                  DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
                ],
                onChanged: (value) => setState(() => _selectedCategory = value!),
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text('Tanggal: ${DateFormat('dd MMM yyyy').format(_selectedDate)}'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => _selectedDate = picked);
                    },
                    child: const Text('Ubah Tanggal'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Catatan (opsional)'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    transactionProvider.updateTransaction(
                      widget.transaction.id,
                      Transaction(
                        id: widget.transaction.id,
                        title: _titleController.text,
                        amount: double.parse(_amountController.text),
                        date: _selectedDate,
                        category: _selectedCategory,
                        type: _selectedType,
                        note: _noteController.text.isEmpty ? null : _noteController.text,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
