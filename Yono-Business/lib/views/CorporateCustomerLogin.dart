import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yonobusiness/models/LoginModel.dart';
import 'package:yonobusiness/services/loginservice.dart';
import 'package:yonobusiness/views/CmpDealerAgentLogin.dart';
import 'package:yonobusiness/views/Create_account-form.dart';
import 'package:yonobusiness/views/CustomerRegistration.dart';
import 'package:yonobusiness/views/TransactionMain.dart';

class CorporateLoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<CorporateLoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xff2a0062), Color(0xff520062)]),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Welcome to Yono Business',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TabBar(
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              tabs: [
                Tab(text: 'Corporate'),
                Tab(text: 'CMP Dealer/Agents'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                LoginForm(),
                CMPLoginForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  LoginService service = LoginService();

  String? _usernameError;
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

  Future<void> login() async {
    LoginModel loginmodel = LoginModel();

    loginmodel.setUsername = usernameController.text;
    loginmodel.setPassword = passwordController.text;

    Response res = await service.saveUser(loginmodel);

    String temp = res.body;

    String expectedMessage = 'Corporate Customer Login Succesfully::';

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
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: _usernameError,
              ),
              onChanged: (value) {
                setState(() {
                  _usernameError = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    _usernameError = 'Username is required';
                  });
                  return _usernameError;
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
                    login();
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.money),
                    Text('SB Collect'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.location_on),
                    Text('Locate us'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerRegister()),
                );
              },
              child: Text(
                'Register Device',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAccountForm(),
                  ),
                );
              },
              child: Text(
                'Open a New Current Account',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            //SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
