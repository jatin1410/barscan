import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class NewFilePage extends StatefulWidget {
  const NewFilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewFilePage> createState() => _NewFilePageState();
}

class _NewFilePageState extends State<NewFilePage> {
  late File file;
  String filename = "Create File";
  String _scanBarcode = "";

   void initState() {
    super.initState();
    // call the function
 //gi   createNewFile();
  }


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
              TextButton(child: const Text('Add'), onPressed: () {}),
              TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ));

  //-----------------------------------------------create New file-----------------------------

  Future createNewFile() async {
    var status = await Permission.storage.status;
    print(status);
    if (!status.isGranted) {
      await Permission.storage.request();
      print("permission  granted");
    } else {
      print("permission not granted");
    }
    Directory? dicr = await getExternalStorageDirectory();
    print(dicr!.path);
    String newPath = "";
    List<String> folders = dicr.path.split("/");
    for (int i = 1; i < folders.length; i++) {
      String folder = folders[i];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath += "/Android/gesl";
    dicr = Directory(newPath);
    print(dicr.path);
    await Directory(dicr.path).create(recursive: true);
    String currentDate = DateFormat('yMd').format(DateTime.now());
    String currentTime = DateFormat.Hm().format(DateTime.now());
    String str = "/barcode.txt";
    final file = File(dicr.path + str);
    print(file);
   
    file.writeAsString("Now file opened");


      final content = await file.readAsString();
       print(content.length);
       print(content);
    print(" hi i am here ! ");
    //   setState(() {
    //     filename = str;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(filename), actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
        )
      ]),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: size.height * 0.65,
            ),

            //----------------------------------------buttons-----------------------------------------
            Container(
              height: size.height * 0.15,
              child: Row(
                children: [
                  InkWell(
                    onTap: createNewFile,
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
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/home/file.png',
                            ),
                            //  Container(height: size.width*0.01,),
                            const Text(
                              "Create",
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                  ), //),
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
                            Image.asset('assets/home/openfile.png'),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Open",
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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
                      child: Center(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
