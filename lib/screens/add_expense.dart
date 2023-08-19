import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_app/provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _saveExpense() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text;
    if (enteredTitle.isEmpty) {
      return;
    }
    ref.read(expenseProvider.notifier).addExpense(
          double.tryParse(enteredAmount)!,
          enteredTitle,
        );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                cursorColor: Colors.amber,
                decoration: const InputDecoration(
                  hoverColor: Colors.amber,
                  fillColor: Colors.amber,
                  iconColor: Colors.amber,
                  focusColor: Colors.amber,
                  label: Text("Title"),
                ),
                controller: _titleController,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                cursorColor: Colors.amber,
                decoration: const InputDecoration(
                  prefixText: '₹',
                  label: Text("Amount"),
                ),
                controller: _amountController,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 255, 191, 0)),
                ),
                onPressed: _saveExpense,
                icon: const Icon(Icons.add),
                label: Text(
                  "Add Expense",
                  style: GoogleFonts.montserrat(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
