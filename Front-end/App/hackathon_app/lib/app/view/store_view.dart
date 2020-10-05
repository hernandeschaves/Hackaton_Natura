import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hackathon_app/app/model/produto_model.dart';
import 'package:hackathon_app/main.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<String> carouselImages = [
    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.sh9rc3XCoDp4_YNgN12IzQHaD3%26pid%3DApi&f=1',
    'https://s-media-cache-ak0.pinimg.com/736x/07/11/38/071138326a4718464d97f4fca16b5d14.jpg',
    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.ZoqixSF1Fucmmimn3P4dIQHaEf%26pid%3DApi&f=1',
    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.qQSWY0351zMi3uPbzAl-6QHaE0%26pid%3DApi&f=1',
    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.CtzY6lUN1_D--QT7EqG0tgHaCw%26pid%3DApi&f=1',
  ];

  @override
  Widget build(BuildContext context) {
    DocumentReference userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(userController.user.id);
    return Scaffold(
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
                Navigator.pushNamed(context, '/addsaldo');
              },
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Produtos',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color(0xffff8a4d),
      ),
      backgroundColor: Color(0xffffbb7b),
      //Responsável pelo scroll da página
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: carouselImages.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image: DecorationImage(
                            image: NetworkImage(i),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Produtos na máquina',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              //Setando a List como não scrollable, pois o widget SingleChildScrollView é responsável por isso
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: machineController.listProductsMachine.length,
              itemBuilder: (BuildContext context, int index) {
                String nome =
                    machineController.listProductsMachine[index]['nome'];
                String preco = machineController.listProductsMachine[index]
                        ['price']
                    .toStringAsFixed(2);
                String descricao =
                    machineController.listProductsMachine[index]['descricao'];
                int quantidade =
                    machineController.listProductsMachine[index]['quantidade'];
                String urlImage =
                    machineController.listProductsMachine[index]['urlImage'];
                return Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      print('Clicou no índice: $index');
                      produtoController.setProduto(ProdutoModel(
                        id: index,
                        name: nome,
                        descricao: descricao,
                        urlImage: urlImage,
                        preco: double.parse(preco),
                        quantidade: quantidade,
                      ));
                      Navigator.pushNamed(context, '/payment');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40,
                      height: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width - 72) *
                                (1 / 3),
                            decoration: BoxDecoration(
                              //color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  urlImage,
                                ),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width - 72) *
                                (2 / 3),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nome,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    'R\$ ' + preco,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
