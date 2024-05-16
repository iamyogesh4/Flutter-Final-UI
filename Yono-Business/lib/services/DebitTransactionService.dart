import 'dart:convert';
import 'package:http/http.dart' as http;

class DebitTransactionService {
  Future<bool> checkBalance(String fromAccountNumber, int amount) async {
    try {
      var url =
          Uri.parse('http://localhost:9092/total-amount/$fromAccountNumber');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        double balance = double.parse(response.body);
        return balance >= amount;
      } else {
        throw Exception(
            "Failed to check balance. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error checking balance: $e");
    }
  }

  Future<void> debitTransaction(String toAccountNumber,
      String fromAccountNumber, int amount, String purpose) async {
    try {
      bool hasSufficientBalance = await checkBalance(fromAccountNumber, amount);
      if (!hasSufficientBalance) {
        throw Exception("Insufficient balance in the from account for debit.");
      }

      var url = Uri.parse('http://localhost:9092/debit');
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": "Bearer " + await getApiKey()
      };
      Map<String, dynamic> data = {
        "toAccountNumber": toAccountNumber,
        "fromAccountNumber": fromAccountNumber,
        "amount": amount,
        "purpose": purpose
      };
      var body = json.encode(data);
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode != 200) {
        throw Exception(
            "Failed to debit amount. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error debiting amount: $e");
    }
  }

  Future<String> getApiKey() async {
    return 'my-secure-api-key';
  }
}
