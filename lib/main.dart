import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'wallet_provider.dart';

void main() {
  runApp(ChangeNotifierProvider<WalletProvider>(
    create: (context) => WalletProvider(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  final mnemonic = walletProvider.generateMnemonic();
                  final privateKey =
                      await walletProvider.getPrivateKey(mnemonic);
                  final publicKey =
                      await walletProvider.getPublicKey(privateKey);
                  print("mnemonic: $mnemonic");
                  print("privateKey: $privateKey");
                  print("publicKey: $publicKey");
                },
                child: Text("Generate Mnemonic")),
          ],
        )),
      ),
    );
  }
}
