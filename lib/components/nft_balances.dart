import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/get_nfts.dart';

class NFTListPage extends StatefulWidget {
  final String address;
  final String chain;

  const NFTListPage({
    Key? key,
    required this.address,
    required this.chain,
  }) : super(key: key);

  @override
  _NFTListPageState createState() => _NFTListPageState();
}

class _NFTListPageState extends State<NFTListPage> {
  List<dynamic> _nftList = [];

  @override
  void initState() {
    super.initState();
    _loadNFTList();
  }

  Future<void> _loadNFTList() async {
    final response = await getUserNFTs(widget.address, widget.chain);
    setState(() {
      _nftList = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var nft in _nftList)
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${nft['name']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 200, // adjust the height as needed
                  child: nft['normalized_metadata']['image'] != null
                      ? Image.network(
                          nft['normalized_metadata']['image'],
                          fit: BoxFit.contain,
                        )
                      : const Center(
                          child: Text('Img'),
                        ),
                ),
                Text(
                  '${nft['normalized_metadata']['description']}',
                ),
              ],
            ),
          ),
      ],
    );
  }
}
