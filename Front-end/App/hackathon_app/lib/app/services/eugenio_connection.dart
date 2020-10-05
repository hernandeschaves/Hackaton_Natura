import 'package:http/http.dart';

class EugenioConnetion {
  final email = "renansa27@gmail.com";
  final password = "ConexaoEugenio27";
  Future<Response> connetcion() async {
    var url = "https://portal.stg.eugenio.io/api/v1/auth";
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    String json = '{"email":"$email", "password":"$password"}';

    Response response = await post(
      url,
      headers: headers,
      body: json,
    );
    print(response.body);
    return response;
  }
}
