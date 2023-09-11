import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = "";

  //-----------------------------------------barcode scan function----------------------
  scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
   //   print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      openDialog1();
    });
  }
//-------------------------------------------alertmsg of barcode value-----------------------------
  openDialog1() => showDialog(
      context: context,
      builder: (builder) => AlertDialog(
            alignment: Alignment.center,
            elevation: 5,
            backgroundColor: Colors.orange[500],
            contentPadding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            title: const Text("Attention"),
            content: Text("Barcode value : $_scanBarcode"),
            actions: [
                  ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        IconButton(
          onPressed: scanBarcodeNormal,
          icon: const Icon(Icons.qr_code_2_outlined),
        )
      ]),
      body: Container(),
    );
  }

  void closeBox() {
  }
}
