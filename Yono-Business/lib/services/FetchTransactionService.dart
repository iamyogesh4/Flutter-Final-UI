import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchTransactionService {
  Future<List<Transaction>> getAllTransactions() async {
    try {
      var url = Uri.parse('http://localhost:9092/all');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        List<Transaction> transactions =
            data.map((json) => Transaction.fromJson(json)).toList();
        return transactions;
      } else {
        throw Exception(
            "Failed to fetch transactions. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching transactions: $e");
    }
  }
}

class Transaction {
  final int id;
  final String fromAccountNumber;
  final String toAccountNumber;
  final int amount;
  final String transactionType;
  final String transactionDateTime;

  Transaction(
      {required this.id,
      required this.fromAccountNumber,
      required this.toAccountNumber,
      required this.amount,
      required this.transactionType,
      required this.transactionDateTime});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        id: json['id'],
        fromAccountNumber: json['fromAccountNumber'],
        toAccountNumber: json['toAccountNumber'],
        amount: json['amount'],
        transactionType: json['transactionType'],
        transactionDateTime: json['transactionDateTime']);
  }
}
