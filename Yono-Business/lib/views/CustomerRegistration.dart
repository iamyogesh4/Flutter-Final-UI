import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yonobusiness/models/RegistrationModel.dart';
import 'package:yonobusiness/services/customerregservice.dart';
import 'package:yonobusiness/views/CorporateCustomerLogin.dart';

class CustomerRegister extends StatefulWidget {
  @override
  _CustomerRegisterState createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister>
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
                Tab(text: 'CMP Dealer/Agent'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: RegisterForm(),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CorporateLoginPage()),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
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

class RegisterForm extends StatefulWidget {
  @override
  RegistartionFormState createState() => RegistartionFormState();
}

class RegistartionFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  //create the service class object

  Service service = Service();

  String? _nameError;
  String? _emailError;
  String? _usernameError;
  String? _passwordError;
  String? _addressError;
  String? _mobileError;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Process Completed'),
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
          title: Text('Problem In Registartion Process'),
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

  Future<void> registration() async {
    RegistrationModel registrationmodel = RegistrationModel();

    registrationmodel.setName = nameController.text;
    registrationmodel.setEmail = emailController.text;
    registrationmodel.username = usernameController.text;
    registrationmodel.password = passwordController.text;
    registrationmodel.address = addressController.text;
    registrationmodel.mobileNo = mobileController.text;

    Response response = await service.saveUser(registrationmodel);

    _showSuccessDialog();
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
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: _nameError,
              ),
              onChanged: (value) {
                setState(() {
                  _nameError = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    _nameError = 'Name is required';
                  });
                  return _nameError;
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailError,
              ),
              onChanged: (value) {
                setState(() {
                  _emailError = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    _emailError = 'Email is required';
                  });
                  return _emailError;
                }
                return null;
              },
            ),
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
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                errorText: _addressError,
              ),
              onChanged: (value) {
                setState(() {
                  _addressError = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    _addressError = 'Address is required';
                  });
                  return _addressError;
                }
                return null;
              },
            ),
            TextFormField(
              controller: mobileController,
              decoration: InputDecoration(
                labelText: 'Mobile No',
                errorText: _mobileError,
              ),
              onChanged: (value) {
                setState(() {
                  _mobileError = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    _mobileError = 'Mobile No is required';
                  });
                  return _mobileError;
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
                    registration();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurple), // Set button background color
                ),
                child: Text('Register',
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
