import 'package:expense_app/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod/riverpod.dart';
import 'package:expense_app/provider/provider.dart';

class ExpenseItem extends ConsumerWidget {
  ExpenseItem({super.key, required this.expense});
  Expense expense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(expense.id),
      onDismissed: (direction) {
        ref.read(expenseProvider.notifier).deleteExpense(expense.id);
      },
      child: Container(
        height: 80,
        child: Card(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          color: const Color.fromARGB(255, 255, 226, 139),
          elevation: 5,
          margin:
              const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                expense.title,
                style: GoogleFonts.montserrat(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                expense.amount.toString() + ' ₹',
                style: GoogleFonts.montserrat(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
