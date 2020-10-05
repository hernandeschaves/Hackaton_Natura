import 'package:flutter/material.dart';
import 'package:hackathon_app/app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  logout() {
    _auth.singOut().then(
          (value) => Navigator.of(_scaffoldKey.currentContext)
              .pushReplacementNamed('/login'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            logout();
          },
        ),
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color(0xffff8a4d),
      ),
      backgroundColor: Color(0xffffbb7b),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Para iniciar sua compra, escaneie o QR Code localizado na máquina',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Color(0xffc75b20),
                onPressed: () {
                  Navigator.pushNamed(context, '/qrcodescanner');
                  /* EugenioConnetion conection = EugenioConnetion();
                  conection.connetcion().then((value) =>
                      print(value.statusCode.toString() + "\n" + value.body)); */
                },
                child: Container(
                  height: 100,
                  width: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_outlined,
                        size: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
