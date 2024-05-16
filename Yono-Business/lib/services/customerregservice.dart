import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yonobusiness/models/RegistrationModel.dart';

class Service {
//create the method  to save user

  Future<http.Response> saveUser(RegistrationModel regmodel) async {
    //creare URI

    var uri = Uri.parse("http://localhost:2000/corpcustomer/addcorpcust");

    //create Header

    Map<String, String> header = {"Content-type": "application/json"};

    //create body

    Map data = {
      'name': regmodel.getName,
      'email': regmodel.getEmail,
      'username': regmodel.getUsername,
      'password': regmodel.getPassword,
      'mobile': regmodel.getMobileno,
      'address': regmodel.getAddress
    };

    //convert the above data into Json
    var body = json.encode(data);

    var response = await http.post(uri, headers: header, body: body);

    //print the above response

    print("${response.body}");

    return response;
  }
}
