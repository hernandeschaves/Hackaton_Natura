import 'package:hackathon_app/app/model/produto_model.dart';
import 'package:mobx/mobx.dart';
part 'produto_controller.g.dart';

class ProdutoController = _ProdutoControllerBase with _$ProdutoController;

abstract class _ProdutoControllerBase with Store {
  @observable
  ProdutoModel produto = ProdutoModel();

  @observable
  int quantidadeCliente = 1;

  @action
  setProduto(ProdutoModel produto) {
    this.produto = produto;
  }

  @action
  incrementQtdCliente() {
    this.quantidadeCliente++;
  }

  @action
  decrementQtdCliente() {
    if (this.quantidadeCliente > 1) {
      this.quantidadeCliente--;
    }
  }

  @computed
  double get totalCompra =>
      quantidadeCliente * double.parse(produto.preco.toStringAsFixed(2));
}
