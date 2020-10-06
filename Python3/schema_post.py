import requests

payload = "{ \"method\": \"qrcode_app\",  \"payload\": \"numero_qrcode\",  \"timeout\": 10 }";

headers = {
    'apikey': "oO6yJhcsnK4YpVSQUO4sU2PYrkn3aThW",
    'content-type': "application/json"
    }
deviceId = "10d21a8e-1a08-4fc0-b5ad-4bd1c9a79f13"

response = requests.request("POST", 'https://portal.stg.eugenio.io/api/v1/things/'+deviceId+'/invoke', data=payload, headers=headers)

print(response.text)
