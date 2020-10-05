// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoController on _ProdutoControllerBase, Store {
  Computed<double> _$totalCompraComputed;

  @override
  double get totalCompra =>
      (_$totalCompraComputed ??= Computed<double>(() => super.totalCompra,
              name: '_ProdutoControllerBase.totalCompra'))
          .value;

  final _$produtoAtom = Atom(name: '_ProdutoControllerBase.produto');

  @override
  ProdutoModel get produto {
    _$produtoAtom.reportRead();
    return super.produto;
  }

  @override
  set produto(ProdutoModel value) {
    _$produtoAtom.reportWrite(value, super.produto, () {
      super.produto = value;
    });
  }

  final _$quantidadeClienteAtom =
      Atom(name: '_ProdutoControllerBase.quantidadeCliente');

  @override
  int get quantidadeCliente {
    _$quantidadeClienteAtom.reportRead();
    return super.quantidadeCliente;
  }

  @override
  set quantidadeCliente(int value) {
    _$quantidadeClienteAtom.reportWrite(value, super.quantidadeCliente, () {
      super.quantidadeCliente = value;
    });
  }

  final _$_ProdutoControllerBaseActionController =
      ActionController(name: '_ProdutoControllerBase');

  @override
  dynamic setProduto(ProdutoModel produto) {
    final _$actionInfo = _$_ProdutoControllerBaseActionController.startAction(
        name: '_ProdutoControllerBase.setProduto');
    try {
      return super.setProduto(produto);
    } finally {
      _$_ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic incrementQtdCliente() {
    final _$actionInfo = _$_ProdutoControllerBaseActionController.startAction(
        name: '_ProdutoControllerBase.incrementQtdCliente');
    try {
      return super.incrementQtdCliente();
    } finally {
      _$_ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decrementQtdCliente() {
    final _$actionInfo = _$_ProdutoControllerBaseActionController.startAction(
        name: '_ProdutoControllerBase.decrementQtdCliente');
    try {
      return super.decrementQtdCliente();
    } finally {
      _$_ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
produto: ${produto},
quantidadeCliente: ${quantidadeCliente},
totalCompra: ${totalCompra}
    ''';
  }
}
