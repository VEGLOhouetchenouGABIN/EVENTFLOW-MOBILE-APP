// import 'dart:ui';
// import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:eventflow/widgets/deodat/widgets/default_button.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanner"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: const TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            DefaultButton(
              onPressed: () async {
                try {
                  ScanResult result =
                      await BarcodeScanner.scan(); // Barcode scanner
                  String codeScanner = result.rawContent;
                   String eventId = codeScanner.replaceAll(RegExp(r'[^0-9]'), "");

                  if (codeScanner != qrCodeResult) {
                    setState(() {
                      qrCodeResult = eventId;
                    });
                  }
                } on PlatformException catch (e) {
                  // Handle exceptions here
                  if (e.code == BarcodeScanner.cameraAccessDenied) {
                    print("User has denied camera access permissions");
                    // You can show a message to the user
                  } else if (e.code == "userCanceled") {
                    print("User has canceled the scanning process");
                    // You can show a message to the user
                  } else {
                    print("An unexpected error occurred: $e");
                    // You can handle other exceptions here
                  }
                } catch (e) {
                  // Handle other exceptions
                  print("An unexpected error occurred: $e");
                }
              },
              child: const Text(
                "Open Scanner",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
