import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAccountService {
  Future<http.Response> createAccount(String accountHolderName, String email,
      int balance, String phoneNumber) async {
    var url = Uri.parse('http://localhost:9091/createAccount');
    Map<String, String> header = {"Content-type": "application/json"};

    Map<String, dynamic> data = {
      "accountHolderName": accountHolderName,
      "email": email,
      "balance": balance,
      "phoneNumber": phoneNumber
    };

    var body = json.encode(data);

    var response = await http.post(url, headers: header, body: body);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return response;
    } else {
      print(response.statusCode);
      print(response.body);

      if (response.body.isNotEmpty) {
        try {
          var responseBody = json.decode(response.body);
        } catch (e) {
          print('Failed to decode JSON response: $e');
        }
      }

      throw Exception('Failed to create account');
    }
  }
}
