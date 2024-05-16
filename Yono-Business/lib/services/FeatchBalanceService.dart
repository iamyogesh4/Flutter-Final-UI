import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchBalanceService {
  Future<http.Response> fetchBalance(String accountNumber) async {
    var url = Uri.parse('http://localhost:5000/api/fetchBalence');

    Map<String, String> header = {"Content-type": "application/json"};

    Map<String, dynamic> data = {"accountNumber": '${accountNumber}'};

    var body = json.encode(data);

    var response1 = await http.post(url, headers: header, body: body);

    if (response1.statusCode == 200) {
      return response1;
      print('$response1');
    } else {
      throw Exception('Failed to Get Balance');
      print('$response1');
    }
  }
}
