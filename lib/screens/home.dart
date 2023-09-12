import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = "";
  String currentDate = DateFormat('yMd').format(DateTime.now());
  String currentTime = DateFormat.Hm().format(DateTime.now());

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
              TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        IconButton(
          onPressed: scanBarcodeNormal,
          icon: const Icon(Icons.qr_code_2_outlined),
        )
      ]),
      body: SafeArea(
        child: ListView(
          children: [
            //card
            Container(
              height: size.height * 0.05,
            ),
            Container(
              height: size.height * 0.25,
              width: size.width * 0.5,
              // padding:EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blue[600]),
              // padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.1,
                  ),
                  Container(
                    // padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                    //  height: size.height*0.15,
                    child: const Text(
                      "GESL",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  Container(
                    height: size.height * 0.05,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(27.0, 0.0, 27.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Text(currentDate),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(currentTime),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.35,
            ),
            //buttons
            Container(
              height: size.height * 0.15,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.28,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[300]),
                      margin: EdgeInsets.fromLTRB(
                          size.width * 0.05,
                          size.height * 0.01,
                          size.width * 0.025,
                          size.height * 0.01),
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.08,
                          size.height * 0.00,
                          size.width * 0.08,
                          size.width * 0.0),
                      child:  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                         Image.asset(
                            'assets/home/openfile.png',
                          ),
                //  Container(height: size.width*0.01,),
                           const Text(
                              "Existing",
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                  ), //),
                  InkWell(
                    onTap: scanBarcodeNormal,
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.28,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[300]),
                      margin: EdgeInsets.fromLTRB(0.0, size.height * 0.01,
                          size.width * 0.025, size.height * 0.01),
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.08,
                          size.height * 0.00,
                          size.width * 0.08,
                          size.width * 0.0),
                      child:  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                            Image.asset('assets/home/scan.png'),
                          const SizedBox(
                            height: 5,
                          ),
                            const Text(
                              "Scan",
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                   InkWell(
                    onTap: () {},
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.28,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[300]),
                      margin: EdgeInsets.fromLTRB(0.0, size.height * 0.01,
                          size.width * 0.025, size.height * 0.01),
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.08,
                          size.height * 0.00,
                          size.width * 0.08,
                          size.width * 0.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                            Image.asset('assets/home/file.png'),
                          const SizedBox(
                            height: 5,
                          ),
            
                           const Text(
                              "New",
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
