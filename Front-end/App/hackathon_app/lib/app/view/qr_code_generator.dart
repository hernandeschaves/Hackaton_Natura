import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackathon_app/main.dart';

import 'package:qr_flutter/qr_flutter.dart';

class QRCreatorWidget extends StatelessWidget {
  final GlobalKey _globalKey = new GlobalKey();
  final Color bgColor = Color(0xffffbb7b);
  final Color fgColor = Color(0xff501c00);
  final String text = "${userController.user.id}";
  final myStream = FirebaseFirestore.instance
      .collection('Machines')
      .doc(machineController.id)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffbb7b),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Autenticação do cliente",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xffff8a4d),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Mostre o QR Code para o leitor da máquina para fazer sua validação',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              if (text != "")
                Column(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: RepaintBoundary(
                        key: _globalKey,
                        child: QrImage(
                          data: text,
                          backgroundColor: bgColor,
                          foregroundColor: fgColor,
                          size: MediaQuery.of(context).size.width / 1.8,
                        ),
                      ),
                    ),
                  ],
                ),
              RaisedButton(
                  child: Text('Printa Stream'),
                  onPressed: () {
                    myStream.first.then((value) => print(value.data().values));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
