import 'package:flutter/material.dart';
import 'package:yonobusiness/services/CreditTransactionService.dart';

class CreditPage extends StatefulWidget {
  @override
  _CreditPageState createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  TextEditingController toAccountNumberController = TextEditingController();
  TextEditingController fromAccountNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  CreditTransactionService service = CreditTransactionService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: fromAccountNumberController,
              decoration: InputDecoration(
                labelText: 'From Account',
                hintText: 'Enter From Account',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter Amount',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: purposeController,
              decoration: InputDecoration(
                labelText: 'Purpose',
                hintText: 'Enter Purpose',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: toAccountNumberController,
              decoration: InputDecoration(
                labelText: 'To Account',
                hintText: 'Enter To Account',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                int amount = int.tryParse(amountController.text) ?? 0;
                String toAccount = toAccountNumberController.text;
                String fromAccount = fromAccountNumberController.text;
                String purpose = purposeController.text;

                try {
                  bool hasSufficientBalance =
                      await service.checkBalance(fromAccount, amount);
                  if (hasSufficientBalance) {
                    await service.creditTransaction(
                        toAccount, fromAccount, amount, purpose);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Success"),
                          content: Text(
                              "Amount $amount Rs has been credited to account $toAccount."),
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
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(
                              "From account does not have sufficient balance for credit."),
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
                  }
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("Failed to credit amount: $e"),
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
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.deepPurple,
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
