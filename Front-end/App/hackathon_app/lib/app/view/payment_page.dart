import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hackathon_app/app/services/connection.dart';
import 'package:hackathon_app/main.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
        .doc(userController.user.id);
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
                    'Seus Creditos são R\$ ${userController.user.saldo.toStringAsFixed(2)}');
                Navigator.pushNamed(context, '/addsaldo');
              },
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Pagamento',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color(0xffff8a4d),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    produtoController.produto.urlImage,
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descrição',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    produtoController.produto.descricao,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Quantidade',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Observer(builder: (_) {
                    return Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    produtoController.decrementQtdCliente();
                                  },
                                  icon: Icon(Icons.remove)),
                              Text(
                                '${produtoController.quantidadeCliente}',
                                style: TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                  onPressed: () {
                                    produtoController.incrementQtdCliente();
                                  },
                                  icon: Icon(Icons.add)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            'Total: ${(produtoController.produto.preco * produtoController.quantidadeCliente).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 120,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.0),
          color: Color(0xffc75b20),
        ),
        child: FlatButton(
          onPressed: () {
            // Efetuar pagamento
            if (userController.user.saldo >=
                produtoController.produto.preco *
                    produtoController.quantidadeCliente) {
              if (produtoController.produto.quantidade >=
                  produtoController.quantidadeCliente) {
                _setLoading();
                //Realizar Pagamento
                print("Realizar compra");
                connection.realizarCompra().then((value) {
                  if (value) {
                    _setLoading();
                    print('Compra realizada com sucesso!');
                    //Solicitar Produto a máquina
                  } else {
                    _setLoading();
                    print("Compra não realizada!");
                  }
                });
              } else {
                print('Estoque insuficiente');
              }
            } else {
              print("Saldo insuficiente");
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (comprando)
                Row(
                  children: [
                    Text(
                      "Finalizar Compra",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ],
                ),
              if (!comprando)
                Text(
                  "Finalizar Compra",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
            ],
          ),
          color: Colors.transparent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
