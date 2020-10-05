import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/app/controller/produto_controller.dart';
import 'package:hackathon_app/app/controller/user_controller.dart';
import 'package:hackathon_app/app/view/payment_page.dart';
import 'app/controller/machine_controller.dart';
import 'app/view/add_saldo.dart';
import 'app/view/home_view.dart';
import 'app/view/login_view.dart';
import 'app/view/qr_code_generator.dart';
import 'app/view/qr_code_scanner.dart';
import 'app/view/sign_up.dart';
import 'app/view/store_view.dart';
import 'package:firebase_core/firebase_core.dart';

//Instâncias do Mobx
final userController = UserController();
final produtoController = ProdutoController();
final machineController = MachineController();

Future<void> main() async {
  //Duas linhas necessárias para o funcinamento do Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Para o display ficar sempre na vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Natura In Box',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signin': (context) => SignUp(),
        '/home': (context) => Home(),
        '/qrcodescanner': (context) => QRViewWidget(),
        '/qrcodegenerator': (context) => QRCreatorWidget(),
        '/store': (context) => Store(),
        '/payment': (context) => PaymentPage(),
        '/addsaldo': (context) => AddSaldo(),
      },
    );
  }
}
