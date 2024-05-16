import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yonobusiness/models/CMPAgentLoginModel.dart';
import 'package:yonobusiness/models/LoginModel.dart';
import 'package:yonobusiness/services/CMPAgentLoginService.dart';
import 'package:yonobusiness/services/loginservice.dart';

import 'package:yonobusiness/views/TransactionMain.dart';

class CMPLoginForm extends StatefulWidget {
  @override
  CmpLoginFormState createState() => CmpLoginFormState();
}

class CmpLoginFormState extends State<CMPLoginForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  CMPAgentLoginService service = CMPAgentLoginService();

  String? _mobilenoError;
  String? _passwordError;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('Welcome To Yono Business '),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> cmplogin() async {
    CmpDealerAgentLoginModel cmploginmodel = CmpDealerAgentLoginModel();

    cmploginmodel.setMobileNo = mobileNoController.text;
    cmploginmodel.setPassword = passwordController.text;

    Response res = await service.saveUser(cmploginmodel);

    String temp = res.body;

    String expectedMessage = 'CMP/AGENT  Login Succesfully::';

    if (temp == expectedMessage.trim()) {
      // If successful, navigate to the home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePageTransaction()),
      );

      _showSuccessDialog();
    } else {
      _showErrorDialog();
      print('Login failed: $temp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: mobileNoController,
              decoration: InputDecoration(
                labelText: 'MobileNumber',
                errorText: _mobilenoError,
              ),
              onChanged: (value) {
                setState(() {
                  _mobilenoError = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    _mobilenoError = 'MobileNo is required';
                  });
                  return _mobilenoError;
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passwordError,
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _passwordError = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    _passwordError = 'Password is required';
                  });
                  return _passwordError;
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 400.0,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    cmplogin();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurple), // Set button background color
                ),
                child: Text('Login',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
