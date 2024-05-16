import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yonobusiness/services/FetchTransactionService.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class FetchTransaction extends StatefulWidget {
  @override
  _FetchTransactionState createState() => _FetchTransactionState();
}

class _FetchTransactionState extends State<FetchTransaction> {
  late Future<List<Transaction>> _futureTransactions;

  @override
  void initState() {
    super.initState();
    _futureTransactions = FetchTransactionService().getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Transaction>>(
                future: _futureTransactions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return TransactionTable(transactions: snapshot.data!);
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionTable extends StatefulWidget {
  final List<Transaction> transactions;

  TransactionTable({required this.transactions});

  @override
  _TransactionTableState createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable> {
  bool _downloading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.deepPurple),
            columnSpacing: 20,
            dataRowHeight: 50,
            columns: [
              DataColumn(
                label: SizedBox(
                  width: 60,
                  child: Text('ID', style: TextStyle(color: Colors.white)),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 120,
                  child: Text('From Account',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 120,
                  child:
                      Text('To Account', style: TextStyle(color: Colors.white)),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 100,
                  child: Text('Amount', style: TextStyle(color: Colors.white)),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 140,
                  child: Text('Transaction Type',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 180,
                  child: Text('Transaction Date',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
            rows: widget.transactions.map((transaction) {
              return DataRow(cells: [
                DataCell(Text(transaction.id.toString())),
                DataCell(Text(transaction.fromAccountNumber)),
                DataCell(Text(transaction.toAccountNumber)),
                DataCell(Text(transaction.amount.toString())),
                DataCell(Text(transaction.transactionType.toString())),
                DataCell(Text(transaction.transactionDateTime.toString())),
              ]);
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Call function to download PDF
            downloadPDF(widget.transactions);
          },
          child: Text('Download PDF'),
        ),
        SizedBox(height: 10),
        if (_downloading) ...[
          CircularProgressIndicator(), // Show progress indicator while downloading
          SizedBox(height: 5),
          Text('Downloading PDF...'), // Display download message
        ],
      ],
    );
  }

  // Function to download PDF
  void downloadPDF(List<Transaction> transactions) async {
    setState(() {
      _downloading = true; // Set downloading state to true
    });

    var url = Uri.parse('http://localhost:9092/transactions/pdf');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      var blob = html.Blob([bytes]);
      var url = html.Url.createObjectUrlFromBlob(blob);
      var anchor = html.AnchorElement(href: url);
      anchor.download = 'transaction_history.pdf';
      anchor.click();
      html.Url.revokeObjectUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download PDF'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    setState(() {
      _downloading =
          false; // Set downloading state to false after download completes
    });
  }
}
