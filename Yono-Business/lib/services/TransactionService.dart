import 'dart:convert';

import 'package:http/http.dart' as http;

class TransactionService {
  Future<http.Response> debitTrasaction(
      String toAccountNumber, String fromAccountNumber, int amount) async {
    //creare Url

    var url = Uri.parse('http://localhost:9092/debit');

    //create header

    Map<String, String> header = {"Content-type": "application/json"};

    //create data
    //

    Map<String, dynamic> data = {
      "toAccountNumber": '${toAccountNumber}',
      "fromAccountNumber": '${fromAccountNumber}',
      "amount": amount
    };

    var body = json.encode(data);

    var response = await http.post(url, headers: header, body: body);

    // print('${response}');

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(json.decode(response.body));
    } else {
      print(response.statusCode);
    }

    return response;
  }
}