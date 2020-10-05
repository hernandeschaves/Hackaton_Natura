import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/app/model/user_model.dart';
import 'dart:async';
import 'package:hackathon_app/main.dart';

class ConnectionFirebase {
  final UserModel user;
  UserModel get currentUser => user;
  ConnectionFirebase({this.user});
  final databaseUser = FirebaseFirestore.instance.collection("Users");

  Future createUser(UserModel user) async {
    try {
      await databaseUser.doc(user.id).set(user.toJson());
      userController.setUserModel(user);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future<void> createMachine(String id) async {
    final machine = FirebaseFirestore.instance.collection("Machines");
    try {
      DocumentSnapshot res = await machine.doc(id).get();
      //Seta o ID da máquina que está atendendo o cliente
      machineController.setId(id);
      //Seta a lista de produtos da máquina
      machineController.setProductsMap(res.data()['listProductsMachine']);
      //print(machineController.listProductsMachine);
    } catch (e) {
      print(e);
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await databaseUser.doc(uid).get();
      print(userData.data());
      return UserModel.fromData(userData.data());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future<bool> realizarCompra() async {
    print('Total Mobx: ${produtoController.totalCompra}');
    double total = double.parse(
        (userController.user.saldo - produtoController.totalCompra)
            .toStringAsFixed(2));
    userController.setUserModelSaldo(total);
    print(userController.user);
    try {
      await databaseUser
          .doc(userController.user.id)
          .set(userController.user.toJson());
      return true;
    } catch (e) {
      print('Something went wrong!');
      return false;
    }
  }

  Future<bool> addCredito(double credito) async {
    print('Total Mobx: ${produtoController.totalCompra}');
    double total =
        double.parse((userController.user.saldo + credito).toStringAsFixed(2));
    userController.setUserModelSaldo(total);
    print(userController.user);
    try {
      await databaseUser
          .doc(userController.user.id)
          .set(userController.user.toJson());
      return true;
    } catch (e) {
      print('Something went wrong!');
      return false;
    }
  }
}
