import 'package:flutter/material.dart';
import 'FetchTransaction.dart';
import 'CreditPage.dart';
import 'DebitPage.dart';

class MyHomePageTransaction extends StatefulWidget {
  @override
  State<MyHomePageTransaction> createState() => _MyHomePageTransactionState();
}

class _MyHomePageTransactionState extends State<MyHomePageTransaction> {
  bool _showCreditPage = false;
  bool _showDebitPage = false;
  bool _showFetchTransactionPage = false;

  Future<void> disableScreenshot() async {}

  @override
  void initState() {
    super.initState();
    disableScreenshot();
  }

  void toggleFetchTransactionPage() {
    setState(() {
      _showFetchTransactionPage = !_showFetchTransactionPage;
      if (_showFetchTransactionPage) {
        _showCreditPage = false;
        _showDebitPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/yono.png',
                height: 60,
                width: 190,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(0),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "Welcome to yono BUSINESS",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Fund Transfer",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 35),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            buildButton("Credit", () {
                              setState(() {
                                _showCreditPage = !_showCreditPage;
                                if (_showCreditPage) {
                                  _showDebitPage = false;
                                  _showFetchTransactionPage = false;
                                }
                              });
                            }, _showCreditPage),
                            SizedBox(width: 5),
                            buildButton("Debit", () {
                              setState(() {
                                _showDebitPage = !_showDebitPage;
                                if (_showDebitPage) {
                                  _showCreditPage = false;
                                  _showFetchTransactionPage = false;
                                }
                              });
                            }, _showDebitPage),
                            SizedBox(width: 5),
                            buildButton("Check Balance", () {
                              // Handle check balance button click
                            }, false),
                            SizedBox(width: 5),
                            buildButton("View Transaction", () {
                              setState(() {
                                toggleFetchTransactionPage();
                              });
                            }, _showFetchTransactionPage),
                          ],
                        ),
                      ),
                      if (_showCreditPage ||
                          _showDebitPage ||
                          _showFetchTransactionPage) ...[
                        const SizedBox(height: 5),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: _showCreditPage
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 55.0),
                                    child: CreditPage(),
                                  )
                                : _showDebitPage
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top:
                                                0.0), // Reduce top padding here
                                        child: SizedBox(
                                          height:
                                              500, // Provide a finite height
                                          child: DebitPage(),
                                        ),
                                      )
                                    // : _showDebitPage
                                    //     ? Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             top:
                                    //                 0.0), // Reduce top padding here
                                    //         child: SizedBox(
                                    //           height:
                                    //               500, // Provide a finite height
                                    //           child: DebitPage(),
                                    //         ),
                                    //       )
                                    : SizedBox(
                                        height:
                                            1000, // Example height, adjust as needed
                                        child: FetchTransaction(),
                                      ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text, VoidCallback onPressed, bool isSelected) {
    Color buttonColor = isSelected ? Colors.deepPurple : Colors.white;
    Color textColor = isSelected ? Colors.white : Colors.deepPurple;

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurple)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        minimumSize: MaterialStateProperty.all<Size>(const Size(80, 30)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (isSelected) {
              return Colors.deepPurple;
            } else {
              if (states.contains(MaterialState.pressed)) {
                return Colors.deepPurple.withOpacity(0.5);
              } else if (states.contains(MaterialState.hovered)) {
                return Colors.deepPurple.withOpacity(0.2);
              }
              return buttonColor;
            }
          },
        ),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, color: textColor)),
    );
  }
}
