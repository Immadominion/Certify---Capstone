import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class WalletConnect extends StatefulWidget {
  const WalletConnect({super.key});

  @override
  State<WalletConnect> createState() => _WalletConnectState();
}

class _WalletConnectState extends State<WalletConnect> {
  @override
  void initState() {
    super.initState();

    _w3mService.init();
  }

  final _w3mService = W3MService(
    projectId: '2009f3949892128ca51c1d44fd59e939',
    metadata: const PairingMetadata(
      name: 'Web3Modal Flutter Example',
      description: 'Web3Modal Flutter Example',
      url: 'https://www.walletconnect.com/',
      icons: ['https://walletconnect.com/walletconnect-logo.png'],
      redirect: Redirect(
        native: 'flutterdapp://',
        universal: 'https://www.walletconnect.com',
      ),
    ),
  );

  Future<void> callReadFunction() async {
    // Create DeployedContract object using contract's ABI and address
    try {
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(""), // ABI object
          '{YOUR CONTRACT NAME}',
        ),
        EthereumAddress.fromHex('{YOUR CONTRACT ADDRESS}'),
      );

      // Reading values from smart contract
      var result = await _w3mService.requestReadContract(
          topic: "This is the topic",
          chainId: "",
          deployedContract: deployedContract,
          functionName: '{FUNCTION_NAME}',
          // If you are using a different chain then please change the rpcUrl,

          // rpcUrl: 'https://polygon-testnet.public.blastapi.io',
          parameters: ["Parameters?"]);
      log("$result");
    } catch (e) {
      log("$e");
    }
  }

  Future<void> callWriteFunction() async {
    // Create DeployedContract object using contract's ABI and address
    try {
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode("ABI FILE???"), // ABI object
          '{YOUR_CONTRACT_NAME}',
        ),
        EthereumAddress.fromHex('YOUR_CONTRACT_ADDRESS'),
      );

      // await _w3mService.launchConnectedWallet();
      await _w3mService.requestWriteContract(
          topic: _w3mService.session!.topic.toString(),
          // make sure to add eip155: as a prefix before adding your chain id
          // eg: eip155:80001
          chainId: '{YOUR_CHAIN_ID}',
          // make sure to chaine the rpcUrl before proceeding
          // rpcUrl: 'wss://ethereum-sepolia-rpc.publicnode.com',
          deployedContract: deployedContract,
          functionName: '{YOUR_FUNCTION_NAME}',
          parameters: [BigInt.from(0), "wwww"],
          transaction: Transaction(
            from: EthereumAddress.fromHex('{YOUR_WALLET_ADDRESS}'),
          ));
    } catch (e) {
      log("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            W3MNetworkSelectButton(service: _w3mService),
            W3MConnectWalletButton(service: _w3mService),
            ElevatedButton(
                onPressed: () {
                  callReadFunction();
                },
                child: const Text("Call Read")),
            ElevatedButton(
                onPressed: () {
                  callWriteFunction();
                },
                child: const Text("Call Write"))
          ],
        ),
      ),
    );
  }
}
