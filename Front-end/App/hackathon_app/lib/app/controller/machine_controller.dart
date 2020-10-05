import 'package:mobx/mobx.dart';
part 'machine_controller.g.dart';

class MachineController = _MachineControllerBase with _$MachineController;

abstract class _MachineControllerBase with Store {
  @observable
  String id;

  @observable
  ObservableList listProductsMachine = ObservableList.of({});

  @action
  setId(String id) {
    this.id = id;
  }

  @action
  setProductsMap(List listProducts) {
    this.listProductsMachine = listProducts.asObservable();
  }
}
