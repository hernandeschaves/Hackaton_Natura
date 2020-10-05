import 'package:flutter/material.dart';

class OfertasDoDia extends StatefulWidget {
  @override
  _OfertasDoDiaState createState() => _OfertasDoDiaState();
}

class _OfertasDoDiaState extends State<OfertasDoDia> {
  final List produtos = [
    'https://static.natura.com/sites/default/files/styles/product_image_zoom/public/products/69124_1_4.jpg?itok=X2xr3N8u',
    'https://iso.500px.com/wp-content/uploads/2016/04/stock-photo-150595123.jpg',
    'https://iso.500px.com/wp-content/uploads/2016/04/stock-photo-150595123.jpg',
    'https://iso.500px.com/wp-content/uploads/2016/04/stock-photo-150595123.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
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
                width: (MediaQuery.of(context).size.width - 40) * (1 / 3),
                decoration: BoxDecoration(
                  //color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      produtos[0],
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 40) * (2 / 3),
                decoration: BoxDecoration(
                  color: Color(0xffff8a4d),
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
                        'Desodorante Colônia Kaiak Aero Masculino - 100ml',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        'R\$ 74,99',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
