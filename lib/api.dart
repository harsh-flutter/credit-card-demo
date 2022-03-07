import 'dart:convert';
import 'package:flutter_slide/model/CardDetails.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<dynamic> registerUser(
      String name, String email, String password) async {
    // Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final userDetails =
        jsonEncode({"name": name, "email": email, "password": password});
    var response = await http.post(
      Uri.parse(
          'https://flutter-assignment-api.herokuapp.com/v1/auth/register'),
      headers: headers,
      body: userDetails,
    );
    print('Response:: $response');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final userdata = GetStorage();
      var payload = response.body;
      var payloadValue = json.decode(payload);
      var user_token = payloadValue['tokens']['access']['token'];

      String token = user_token;
      userdata.write('token', token);

      return 'Success';
    } else {
      throw Exception('Failed to create album. ${response.body}');
    }
  }

  Future<dynamic> LoginUser(
    String email,
    String password,
  ) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    // Map<String, String> headers = {'Content-Type': 'application/json'};
    final userDetails = jsonEncode({"email": email, "password": password});

    var response = await http.post(
      Uri.parse('https://flutter-assignment-api.herokuapp.com/v1/auth/login'),
      headers: headers,
      body: userDetails,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print('${response.body}' + 'hello');
      final userdata = GetStorage();
      var payload = response.body;
      var payloadValue = json.decode(payload);
      var user_token = payloadValue['tokens']['access']['token'];

      var token = user_token;
      userdata.write('token', token);

      return 'Success';
    } else {
      throw Exception('Failed to create album. ${response.body}');
    }
  }

  Future<dynamic> postCardDetails(CardDetails cardDetails) async {
    final userdata = GetStorage();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': "Bearer " + '${userdata.read('token'.trim())}'
    };
    print("token" + '${userdata.read('token'.trim())}');
    // Map<String, String> headers = {'Content-Type': 'application/json'};
    final card = jsonEncode({
      "name": cardDetails.name,
      "cardExpiration": cardDetails.expiryDate,
      "cardHolder": cardDetails.cardHolder,
      "cardNumber": cardDetails.cardNumber,
      "category": cardDetails.cardCategory
    });
    var response = await http.post(
      Uri.parse('https://flutter-assignment-api.herokuapp.com/v1/cards'),
      headers: headers,
      body: card,
    );
    print('Response:: $response');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'Success';
    } else {
      throw Exception('Failed to create album. ${response.body}');
    }
  }
}
