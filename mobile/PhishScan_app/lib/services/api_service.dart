import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class ApiService {

  static Future<Map<String, dynamic>>
      predictURL(String url) async {

    final response = await http.post(

      Uri.parse(
        '${AppConstants.baseUrl}/predict',
      ),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'url': url,
      }),
    );

    if (response.statusCode == 200) {

      return jsonDecode(response.body);

    } else {

      throw Exception(
        'Failed to detect URL',
      );
    }
  }
}