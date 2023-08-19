import 'package:riverpod/riverpod.dart';
import 'package:expense_app/model/expense_model.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'expenses.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE Expenses(id TEXT PRIMARY KEY, title TEXT, amount REAL)');
    },
    version: 1,
  );
  return db;
}

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super(const []);
  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('Expenses');
    final places = data
        .map(
          (row) => Expense(
            id: row['id'] as String,
            title: row['title'] as String,
            amount: row['amount'] as double,
          ),
        )
        .toList();

    state = places;
  }

  void addExpense(double amount, String title) async {
    final newExpense = Expense(amount: amount, title: title);
    final db = await _getDatabase();
    db.insert('Expenses', {
      'id': newExpense.id,
      'title': newExpense.title,
      'amount': newExpense.amount,
    });
    state = [newExpense, ...state];
  }

  Future<void> deleteExpense(String id) async {
    // Get a reference to the database.
    state = state.where((m) => m.id != id).toList();
    final db = await _getDatabase();

    // Remove the Dog from the database.
    await db.delete(
      'Expenses',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
  (ref) => ExpenseNotifier(),
);
