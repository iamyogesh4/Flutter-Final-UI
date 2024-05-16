import 'package:flutter/material.dart';
import 'package:yonobusiness/services/DebitTransactionService.dart';

class DebitPage extends StatefulWidget {
  @override
  _DebitPageState createState() => _DebitPageState();
}

class _DebitPageState extends State<DebitPage> {
  final TextEditingController toAccountNumberController =
      TextEditingController();
  final TextEditingController fromAccountNumberController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController purposeController =
      TextEditingController(); // Add purpose controller

  final DebitTransactionService service = DebitTransactionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: fromAccountNumberController,
              decoration: InputDecoration(
                labelText: 'From Account',
                hintText: 'Enter From Account',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter Amount',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: purposeController, // Assign purpose controller
              decoration: InputDecoration(
                labelText: 'Purpose',
                hintText: 'Enter Purpose',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: toAccountNumberController,
              decoration: InputDecoration(
                labelText: 'To Account',
                hintText: 'Enter To Account',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                int amount = int.tryParse(amountController.text) ?? 0;
                String fromAccount = fromAccountNumberController.text;
                String toAccount = toAccountNumberController.text;
                String purpose = purposeController.text; // Get purpose

                try {
                  bool hasSufficientBalance =
                      await service.checkBalance(fromAccount, amount);
                  if (hasSufficientBalance) {
                    await service.debitTransaction(toAccount, fromAccount,
                        amount, purpose); // Pass purpose
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Success"),
                          content: Text(
                              "Amount $amount Rs has been debited from account $fromAccount."),
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
                              "From account does not have sufficient balance for debit."),
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
                        content: Text("Failed to debit amount: $e"),
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
