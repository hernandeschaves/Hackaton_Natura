import 'package:hackathon_app/main.dart';
import 'package:http/http.dart';

class EugenioConnetion {
  Future<Response> testeOseias() async {
    var deviceId = "10d21a8e-1a08-4fc0-b5ad-4bd1c9a79f13";
    var url = "https://portal.stg.eugenio.io/api/v1/things/$deviceId/invoke";
    Map<String, String> headers = {
      'apikey': "oO6yJhcsnK4YpVSQUO4sU2PYrkn3aThW",
      "Content-Type": "application/json",
    };
    String json =
        '{ "method": "qrcode_app", "payload": "${userController.user.id}", "timeout": 10 }';

    Response response = await post(
      url,
      headers: headers,
      body: json,
    );
    print(response.body);
    return response;
  }
}
