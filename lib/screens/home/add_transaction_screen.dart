import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/transaction.dart';
import '../../providers/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TransactionType _selectedType = TransactionType.expense;
  String _selectedCategory = 'Makanan';

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: const Color(0xFFF3F7FC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildDropdownType(),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _titleController,
                    label: 'Judul',
                    icon: Icons.title,
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Judul tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _amountController,
                    label: 'Jumlah',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Jumlah tidak boleh kosong';
                      if (double.tryParse(val) == null) return 'Masukkan angka yang valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildCategoryDropdown(),
                  const SizedBox(height: 16),
                  _buildDatePicker(context),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _noteController,
                    label: 'Catatan (opsional)',
                    icon: Icons.note_alt_outlined,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 30),
                  _buildSubmitButton(transactionProvider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownType() {
    return DropdownButtonFormField<TransactionType>(
      value: _selectedType,
      decoration: _inputDecoration(
        label: 'Jenis Transaksi',
        icon: _selectedType == TransactionType.income
            ? Icons.arrow_downward
            : Icons.arrow_upward,
        iconColor: _selectedType == TransactionType.income ? Colors.green : Colors.red,
      ),
      items: TransactionType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type == TransactionType.income ? 'Pemasukan' : 'Pengeluaran'),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) setState(() => _selectedType = value);
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: _inputDecoration(label: 'Kategori', icon: Icons.category),
      items: const [
        DropdownMenuItem(value: 'Makanan', child: Text('Makanan')),
        DropdownMenuItem(value: 'Transportasi', child: Text('Transportasi')),
        DropdownMenuItem(value: 'Hiburan', child: Text('Hiburan')),
        DropdownMenuItem(value: 'Pendidikan', child: Text('Pendidikan')),
        DropdownMenuItem(value: 'Tabungan', child: Text('Tabungan')),
        DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
      ],
      onChanged: (value) {
        if (value != null) setState(() => _selectedCategory = value);
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      decoration: _inputDecoration(label: label, icon: icon),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Tanggal: ${DateFormat('dd MMM yyyy').format(_selectedDate)}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        TextButton.icon(
          icon: const Icon(Icons.calendar_today, color: Color(0xFF1E88E5)),
          label: const Text('Pilih Tanggal'),
          onPressed: () => _selectDate(context),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(TransactionProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E88E5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            provider.addTransaction(
              Transaction(
                id: DateTime.now().toString(),
                title: _titleController.text,
                amount: double.parse(_amountController.text),
                date: _selectedDate,
                category: _selectedCategory,
                type: _selectedType,
                note: _noteController.text,
              ),
            );
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.save_alt_rounded),
        label: const Text(
          'Simpan Transaksi',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Color iconColor = const Color(0xFF1E88E5),
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: iconColor),
      filled: true,
      fillColor: const Color(0xFFF0F4FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}