import 'package:bus_driver/screens/qr_code_confirm_page/qr_code_confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({Key? key}) : super(key: key);

  @override
  _QrCodeScannerPageState createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage> {
  MobileScannerController mobileScanner =  MobileScannerController(facing: CameraFacing.back);
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Align the QR code with the frame to scan"),
      ),
        body: MobileScanner(
          controller: mobileScanner,
          allowDuplicates: true,
          onDetect: (qr,m){
            if (qr.rawValue != null){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=> QrCodeConfirmPage(ticketId: qr.rawValue!,)
                  )
              );
            }
          },
        )
    );
  }
}
