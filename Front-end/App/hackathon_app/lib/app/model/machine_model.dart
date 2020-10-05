class MachineModel {
  String id;
  Map<String, dynamic> productList;

  MachineModel({this.id, this.productList});
  /* MachineModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        saldo = data['saldo'],
        email = data['email'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'saldo': saldo,
    };
  } */
}
