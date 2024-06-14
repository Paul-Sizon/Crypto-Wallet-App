import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<dynamic>> getUserNFTs(String address, String chain) async {
  final apiKey = dotenv.env['MORALIS_API_KEY'];
  if (apiKey == null) {
    throw Exception('API key is not found in the environment variables');
  }

  final url = Uri.https('deep-index.moralis.io', '/api/v2.2/$address/nft', {
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
    final jsonData = json.decode(response.body);
    return jsonData['result'];
  } else {
    throw Exception('Failed to load NFT list data: ${response.statusCode}');
  }
}
