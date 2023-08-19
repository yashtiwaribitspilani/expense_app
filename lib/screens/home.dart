import 'package:expense_app/provider/provider.dart';
import 'package:expense_app/screens/add_expense.dart';
import 'package:expense_app/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _expensesFuture;

  @override
  void initState() {
    super.initState();
    _expensesFuture = ref.read(expenseProvider.notifier).loadPlaces();
  }

  Widget build(BuildContext context) {
    final expenses = ref.watch(expenseProvider);
    double sum = expenses
        .map((expense) => expense.amount)
        .fold(0, (prev, amount) => prev + amount);
    Widget content = ExpenseList(expenses: expenses);

    Widget appBar = Text(
      sum.toString() + " ₹",
      style: GoogleFonts.montserrat(
          color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
    );
    if (expenses.isEmpty) {
      appBar = Text('No Expense Added');
    }
    if (expenses.isEmpty) {
      content = Center(
        child: Text('Add an expense'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: appBar,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder(
            future: _expensesFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : content),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 191, 0),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddExpenseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
