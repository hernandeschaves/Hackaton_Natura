// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MachineController on _MachineControllerBase, Store {
  final _$idAtom = Atom(name: '_MachineControllerBase.id');

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$listProductsMachineAtom =
      Atom(name: '_MachineControllerBase.listProductsMachine');

  @override
  ObservableList<dynamic> get listProductsMachine {
    _$listProductsMachineAtom.reportRead();
    return super.listProductsMachine;
  }

  @override
  set listProductsMachine(ObservableList<dynamic> value) {
    _$listProductsMachineAtom.reportWrite(value, super.listProductsMachine, () {
      super.listProductsMachine = value;
    });
  }

  final _$_MachineControllerBaseActionController =
      ActionController(name: '_MachineControllerBase');

  @override
  dynamic setId(String id) {
    final _$actionInfo = _$_MachineControllerBaseActionController.startAction(
        name: '_MachineControllerBase.setId');
    try {
      return super.setId(id);
    } finally {
      _$_MachineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setProductsMap(List<dynamic> listProducts) {
    final _$actionInfo = _$_MachineControllerBaseActionController.startAction(
        name: '_MachineControllerBase.setProductsMap');
    try {
      return super.setProductsMap(listProducts);
    } finally {
      _$_MachineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
listProductsMachine: ${listProductsMachine}
    ''';
  }
}
