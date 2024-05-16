import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart' as e;
import 'package:flutter/material.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'package:yonobusiness/models/CMPAgentLoginModel.dart';

class CMPAgentLoginService {
//create the method  to save user

  Future<http.Response> saveUser(CmpDealerAgentLoginModel model) async {
    //creare URI

    var uri = Uri.parse("http://localhost:4000/cmp-api/login");

    //create Header

    Map<String, String> header = {"Content-type": "application/json"};

    //encryption method

    final String key = "YourSecretKey123"; // 128-bit key

    final String iv = "YourIV1234567891"; //IV

    final encrypter =
        e.Encrypter(e.AES(e.Key.fromUtf8(key), mode: e.AESMode.cbc));

    final encrypted =
        encrypter.encrypt(model.getPaasword, iv: e.IV.fromUtf8(iv));

    var encryptedText = base64Encode(encrypted.bytes);

    //create body

    Map data = {'mobileno': model.getMobileno, 'password': '$encryptedText'};

    //convert the above data into Json
    var body = json.encode(data);

    var response = await http.post(uri, headers: header, body: body);

    //print the above response

    print("${response.body}");

    return response;
  }
}
