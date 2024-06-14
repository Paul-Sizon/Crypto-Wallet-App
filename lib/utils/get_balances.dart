import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getBalances(String address, String chain) async {
  var apiKey = dotenv.env['MORALIS_API_KEY'] ?? '';
  final url = Uri.https('deep-index.moralis.io', '/api/v2/$address/balance', {
    'chain': chain,
  });

  final response = await http.get(
    url,
    headers: {
      'accept': 'application/json',
      'X-API-Key': apiKey,
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to get balances: ${response.statusCode}');
  }
}
