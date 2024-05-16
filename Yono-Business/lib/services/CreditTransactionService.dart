import 'dart:convert';
import 'package:http/http.dart' as http;

class CreditTransactionService {
  Future<void> creditTransaction(String toAccountNumber,
      String fromAccountNumber, int amount, String purpose) async {
    try {
      var url = Uri.parse('http://localhost:9092/credit');
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
            "Failed to credit amount. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error crediting amount: $e");
    }
  }

  Future<String> getApiKey() async {
    return 'my-secure-api-key';
  }

  Future<bool> checkBalance(String fromAccountNumber, int amount) async {
    try {
      var apiUrl = 'http://localhost:9092/total-amount/$fromAccountNumber';
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        double totalAmount = double.parse(response.body);

        return totalAmount >= amount;
      } else {
        throw Exception(
            'Failed to get account balance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error checking balance: $e');
    }
  }
}
