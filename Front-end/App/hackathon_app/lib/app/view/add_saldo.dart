import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hackathon_app/app/services/connection.dart';

import '../../main.dart';

class AddSaldo extends StatefulWidget {
  @override
  _AddSaldoState createState() => _AddSaldoState();
}

class _AddSaldoState extends State<AddSaldo> {
  bool comprando = false;

  void _setLoading() {
    setState(() {
      comprando = !comprando;
    });
  }

  @override
  Widget build(BuildContext context) {
    ConnectionFirebase connection = ConnectionFirebase();
    DocumentReference userStream = FirebaseFirestore.instance
        .collection('Users')
        //.doc(userController.user.id);
        .doc('wuiSa9uabNRj1xwmYC8xmDmomNF3');
    return Scaffold(
      backgroundColor: Color(0xffffbb7b),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: TextButton(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Seus Créditos:',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: userStream.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      print(snapshot.data.data()['saldo']);
                      userController.setUserModelSaldo(
                          (snapshot.data.data()['saldo']).toDouble());
                      return Text(
                        'R\$ ${snapshot.data.data()['saldo'].toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ],
              ),
              onPressed: () {
                print(
                  'Seus Creditos são R\$ ${userController.user.saldo.toStringAsFixed(2)}',
                );
              },
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Comprar crédito',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color(0xffff8a4d),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            child: FlatButton(
              onPressed: () {
                print('Adicionar R\$ 100');
                connection.addCredito(100.00);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 72) * (1 / 3),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Icon(
                        Icons.monetization_on_outlined,
                        size: 60,
                        color: Color(0xffc75b20),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 72) * (2 / 3),
                      decoration: BoxDecoration(
                        color: Color(0xffc75b20),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Crédito",
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              'R\$ 100,00',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            child: FlatButton(
              onPressed: () {
                print('Adicionar R\$ 150');
                connection.addCredito(150.00);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 72) * (1 / 3),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Icon(
                        Icons.monetization_on_outlined,
                        size: 60,
                        color: Color(0xffc75b20),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 72) * (2 / 3),
                      decoration: BoxDecoration(
                        color: Color(0xffc75b20),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Crédito",
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              'R\$ 150,00',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            child: FlatButton(
              onPressed: () {
                print('Adicionar R\$ 200');
                connection.addCredito(200.00);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 72) * (1 / 3),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Icon(
                        Icons.monetization_on_outlined,
                        size: 60,
                        color: Color(0xffc75b20),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 72) * (2 / 3),
                      decoration: BoxDecoration(
                        color: Color(0xffc75b20),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Crédito",
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              'R\$ 200,00',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            child: FlatButton(
              onPressed: () {
                print('Adicionar R\$ 300');
                connection.addCredito(300.00);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 72) * (1 / 3),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Icon(
                        Icons.monetization_on_outlined,
                        size: 60,
                        color: Color(0xffc75b20),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 72) * (2 / 3),
                      decoration: BoxDecoration(
                        color: Color(0xffc75b20),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Crédito",
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              'R\$ 300,00',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
