// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserController on _UserControllerBase, Store {
  final _$userAtom = Atom(name: '_UserControllerBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$formNameAtom = Atom(name: '_UserControllerBase.formName');

  @override
  String get formName {
    _$formNameAtom.reportRead();
    return super.formName;
  }

  @override
  set formName(String value) {
    _$formNameAtom.reportWrite(value, super.formName, () {
      super.formName = value;
    });
  }

  final _$formEmailAtom = Atom(name: '_UserControllerBase.formEmail');

  @override
  String get formEmail {
    _$formEmailAtom.reportRead();
    return super.formEmail;
  }

  @override
  set formEmail(String value) {
    _$formEmailAtom.reportWrite(value, super.formEmail, () {
      super.formEmail = value;
    });
  }

  final _$formPasswordAtom = Atom(name: '_UserControllerBase.formPassword');

  @override
  String get formPassword {
    _$formPasswordAtom.reportRead();
    return super.formPassword;
  }

  @override
  set formPassword(String value) {
    _$formPasswordAtom.reportWrite(value, super.formPassword, () {
      super.formPassword = value;
    });
  }

  final _$saldoAddAtom = Atom(name: '_UserControllerBase.saldoAdd');

  @override
  double get saldoAdd {
    _$saldoAddAtom.reportRead();
    return super.saldoAdd;
  }

  @override
  set saldoAdd(double value) {
    _$saldoAddAtom.reportWrite(value, super.saldoAdd, () {
      super.saldoAdd = value;
    });
  }

  final _$_UserControllerBaseActionController =
      ActionController(name: '_UserControllerBase');

  @override
  dynamic setFormName(String name) {
    final _$actionInfo = _$_UserControllerBaseActionController.startAction(
        name: '_UserControllerBase.setFormName');
    try {
      return super.setFormName(name);
    } finally {
      _$_UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFormEmail(String email) {
    final _$actionInfo = _$_UserControllerBaseActionController.startAction(
        name: '_UserControllerBase.setFormEmail');
    try {
      return super.setFormEmail(email);
    } finally {
      _$_UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFormPassword(String password) {
    final _$actionInfo = _$_UserControllerBaseActionController.startAction(
        name: '_UserControllerBase.setFormPassword');
    try {
      return super.setFormPassword(password);
    } finally {
      _$_UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserModel(UserModel userModel) {
    final _$actionInfo = _$_UserControllerBaseActionController.startAction(
        name: '_UserControllerBase.setUserModel');
    try {
      return super.setUserModel(userModel);
    } finally {
      _$_UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserModelSaldo(double saldo) {
    final _$actionInfo = _$_UserControllerBaseActionController.startAction(
        name: '_UserControllerBase.setUserModelSaldo');
    try {
      return super.setUserModelSaldo(saldo);
    } finally {
      _$_UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserSaldoAdd(double saldoAdd) {
    final _$actionInfo = _$_UserControllerBaseActionController.startAction(
        name: '_UserControllerBase.setUserSaldoAdd');
    try {
      return super.setUserSaldoAdd(saldoAdd);
    } finally {
      _$_UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
formName: ${formName},
formEmail: ${formEmail},
formPassword: ${formPassword},
saldoAdd: ${saldoAdd}
    ''';
  }
}
