import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:yonobusiness/services/FeatchBalanceService.dart';

//class FetchBalance extends StatelessWidget {}

class FetchAmount extends StatefulWidget {
  @override
  _FetchBalancePageState createState() => _FetchBalancePageState();
}

class _FetchBalancePageState extends State<FetchAmount> {
  TextEditingController accountNumberController = TextEditingController();
  FetchBalanceService service = FetchBalanceService();

  Future<http.Response> fetchRecord(String accountNumber) async {
    var response = await http
        .get(Uri.parse('http://localhost:7000/api/getBalance/$accountNumber'));

    if (response.statusCode == 200) {
      print(response.statusCode);

      print(response.body);
    } else {
      print(response.statusCode);
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avilable Balance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: accountNumberController,
              decoration: InputDecoration(
                labelText: 'Enter Account Number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var response = await fetchRecord(accountNumberController.text);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Balance"),
                      content: Text(response.body),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.redAccent), // Background color of button
              ),
              child: Text('Check Balance',
                  style:
                      TextStyle(color: Colors.white)), // Text color of button
            ),
          ],
        ),
      ),
    );
  }
}
