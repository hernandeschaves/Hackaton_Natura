class UserModel {
  final String id;
  final String name;
  double saldo;
  final String email;
  UserModel({this.id, this.name, this.saldo, this.email});
  UserModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        saldo = double.parse(data['saldo'].toString()),
        email = data['email'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'saldo': saldo,
    };
  }
}
