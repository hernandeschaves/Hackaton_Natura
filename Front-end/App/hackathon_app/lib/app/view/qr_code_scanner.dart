import 'package:flutter/material.dart';
import 'package:hackathon_app/app/services/connection.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewWidget extends StatefulWidget {
  const QRViewWidget({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewWidgetState();
}

class _QRViewWidgetState extends State<QRViewWidget> {
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Color(0xffff8a4d),
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      ConnectionFirebase connection = ConnectionFirebase();
      //A ideia é passar o codigo auth do cliente, assim cada cliente terá um código QR específico
      connection.createMachine(scanData).then(
            (value) => value
                ? Navigator.popAndPushNamed(context, '/store')
                : print('QR Code não reconhecido'),
          );
      //Navigator.popAndPushNamed(context, '/store');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
