import 'package:flutter/material.dart';
import 'package:yonobusiness/services/CreateAccountService.dart';

class CreateAccountForm extends StatefulWidget {
  @override
  _CreateAccountFormState createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  CreateAccountService service = CreateAccountService();
  bool _accountCreated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(0),
              width: 400,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Welcome to yono BUSINESS",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Create Account',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          controller: accountHolderNameController,
                          decoration:
                              InputDecoration(labelText: 'Account Holder Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter account holder name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration:
                              InputDecoration(labelText: 'Phone Number'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: _accountCreated
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    final String accountHolderName =
                                        accountHolderNameController.text;
                                    final String email = emailController.text;
                                    final String phoneNumber =
                                        phoneNumberController.text;

                                    try {
                                      final response =
                                          await service.createAccount(
                                        accountHolderName,
                                        email,
                                        0,
                                        phoneNumber,
                                      );

                                      if (response.statusCode == 200) {
                                        setState(() {
                                          _accountCreated = true;
                                        });
                                        _showSuccessDialog();
                                      }
                                    } catch (e) {
                                      print('Failed to create account: $e');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Failed to create account')));
                                    }
                                  }
                                },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              _accountCreated ? Colors.grey : Colors.deepPurple,
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              StadiumBorder(),
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(""),
          content: Text(
            "Account Created Successfully",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    accountHolderNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: CreateAccountForm(),
  ));
}
