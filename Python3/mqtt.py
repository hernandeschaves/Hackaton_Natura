import json
import logging
import paho.mqtt.client as mqtt
import ssl
from json import loads, dumps
from time import sleep

from kivy.uix.image import Image
from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.lang import Builder
from kivy.uix.popup import Popup
from kivy.uix.boxlayout import BoxLayout
import io
import pyqrcode as pqr

id_raspberry = pqr.create("id_raspberry")
qr_enviar = id_raspberry
with open("code.png", "w") as fstream:
    id_raspberry.png("code.png", scale=20)

id_raspberry.png("code.png", scale=20)
buffer = io.BytesIO()
id_raspberry.png(buffer)

Builder.load_string('''
<GridLayout>
    canvas.before:
        BorderImage:
            # BorderImage behaves like the CSS BorderImage
            border: 10, 10, 10, 10
            source: '/home/atrya/Imagens/natura.jpg'
            pos: self.pos
            size: self.size

<RootWidget>
    GridLayout:
        size_hint: .9, .9
        pos_hint: {'center_x': .5, 'center_y': .5}
        rows:1
        canvas.before:
            BorderImage:
                # BorderImage behaves like the CSS BorderImage
                source: '/home/atrya/Documentos/EUGENIO/APP_EUGENIO/code.png'
                size: 200, 200
                pos: self.pos                   

        Label:
            text: "EUGENIO IoT"
            text_size: self.width-80, self.height-80
            valign: 'top'
        Label:
            text: "When I was born I was so surprised; I didn't speak for a year and a half."
            text_size: self.width-90, self.height-90
            valign: 'middle'
            halign: 'center'
        Label:
            text: "A consultant is someone who takes a subject you understand and makes it sound confusing"
            text_size: self.width-90, self.height-90
            valign: 'bottom'
            halign: 'justify'
''')


class RootWidget(FloatLayout):
    pass


class MainApp(App):

    def build(self):
        return RootWidget()


def gera_qrconfirma():
    qrcode_confirma = pqr.create(decoded_payload)
    with open("qrcode.png", "w") as fstream:
        qrcode_confirma.png("qrcode.png", scale=20)
    qrcode_confirma.png("qrcode.png", scale=20)
    buffer = io.BytesIO()
    qrcode_confirma.png(buffer)


def qrcode_conf():
    box = BoxLayout(orientation='vertical')
    qr = Image(source='/home/atrya/Documentos/EUGENIO/APP_EUGENIO/code.png')
    box.add_widget(qr)
    pop = Popup(title='Qrcode Confirmação!!!', content=box, size_hint=(None, None),
                size=(350, 350))
    pop.open()


class MqttController(object):
    """This class wraps a mqtt client and defines how to handle messages received by the mqtt broker"""

    def __init__(self, broker_mqtt_hostname, broker_mqtt_port):
        """Class constructor

        Args:
            broker_mqtt_hostname: Mqtt broker hostname (usually informed at device registration moment)
            broker_mqtt_port: Mqtt broker port (usually informed at device registration moment)

        """
        self.paho_client_mqtt = None
        self.flag_connected = False

        # Logger related
        self.logger_path = "logger.txt"
        logging.basicConfig(filename=self.logger_path, level=logging.DEBUG)

        # Broker related
        self.broker_mqtt_hostname = broker_mqtt_hostname
        self.broker_mqtt_port = broker_mqtt_port
        self.broker_mqtt_protocol = mqtt.MQTTv311

        #########################################################################################
        # CHANGE HERE
        #########################################################################################
        self.broker_mqtt_CACert = "/home/atrya/Documentos/EUGENIO/eugenio_rpi/eugenio-device-examples/python-example/CAcertificate.cert"

        # Device related
        self.device_id = "10d21a8e-1a08-4fc0-b5ad-4bd1c9a79f13"
        self.client_id = '10d21a8e-1a08-4fc0-b5ad-4bd1c9a79f13'
        self.device_cert = "/home/atrya/Documentos/EUGENIO/eugenio_rpi/eugenio-device-examples/python-example/client_cert.pem"
        self.device_key = "/home/atrya/Documentos/EUGENIO/eugenio_rpi/eugenio-device-examples/python-example/client_key.pem"

        #########################################################################################
        #########################################################################################

        self.username = self.broker_mqtt_hostname + '/' + self.device_id + '/api-version=2019-03-30'

        # Mqtt topics
        self.device_to_cloud_topic = 'devices/' + self.device_id + '/messages/events/'
        self.cloud_to_device_topic = 'devices/' + self.device_id + '/messages/devicebound/'
        self.invoke_base_topic = '$iothub/methods/POST/'
        self.invoke_topic = self.invoke_base_topic + '#'
        self.invoke_reply_topic = '$iothub/methods/res/{status_code}/?$rid={rid}'

        self.__init_mqtt()

    def __init_mqtt(self):
        """Responsible for configuring the internal mqtt client"""

        def on_connect(client, userdata, flags, rc):
            """Callback for when the connection is established with the mqtt broker"""
            try:
                logging.info('MQTT Paho Connected with result code ' + str(rc))
                self.flag_connected = True
                logging.info('Subscribing to invoke topic')
                client.subscribe(self.invoke_topic)
                client.subscribe(self.cloud_to_device_topic)


            except Exception as e:
                logging.warning("on_connect with result error %s" % e)

        def on_message(client, userdata, msg):
            """Callback for when a message is received by client"""
            logging.info('MQTT message arrived')
            print('MQTT message arrived')
            logging.debug('topic %s' % msg.topic)
            print('topic %s' % msg.topic)
            logging.debug('payload %s' % msg.payload)
            print('payload %s' % msg.payload)
            self.handle_mqtt_messages(msg.topic, msg.payload)

        def on_disconnect(client, userdata, rc):
            """Callback for when the connection is lost"""
            self.flag_connected = False
            logging.info('MQTT Disconnected!!')

        self.paho_client_mqtt = mqtt.Client(client_id=self.device_id, protocol=self.broker_mqtt_protocol)
        self.paho_client_mqtt.on_connect = on_connect
        self.paho_client_mqtt.on_message = on_message
        self.paho_client_mqtt.on_disconnect = on_disconnect
        self.paho_client_mqtt.username_pw_set(username=self.username)
        self.paho_client_mqtt.tls_set(ca_certs=self.broker_mqtt_CACert,
                                      certfile=self.device_cert,
                                      keyfile=self.device_key,
                                      cert_reqs=ssl.CERT_REQUIRED,
                                      tls_version=ssl.PROTOCOL_TLSv1_2,
                                      ciphers=None)
        self.paho_client_mqtt.tls_insecure_set(True)

    def __mqtt_connect(self):
        """Connects the mqtt client to the mqtt broker"""
        retry = 1
        while True:
            try:
                logging.debug('MQTT Connect... ' + str(retry))
                self.paho_client_mqtt.connect(host=str(self.broker_mqtt_hostname), port=int(self.broker_mqtt_port))
                print('MQTT Connect... ' + str(retry))
                break

            except Exception as e:
                print('MQTT Connect error: %s' % e)
                logging.error('MQTT Connect error: %s' % e)
                if retry > 3:
                    logging.debug('MQTT Connection FAIL ' + str(retry))
                    break
                retry += 1

    def mqtt_start(self):
        """Starts the mqtt connection"""
        if self.flag_connected:
            self.paho_client_mqtt.loop_start()
        else:
            self.__mqtt_connect()
            self.paho_client_mqtt.loop_start()

    def mqtt_stop(self):
        """Stops the mqtt connection"""
        try:
            self.paho_client_mqtt.loop_stop()
        except Exception as e:
            logging.error('Failed to stop mqtt: %s' % e)

    def mqtt_publish(self, payload):
        """Publishes a mqtt message at the default event topic for this device

        Args:
            payload: Message payload

        Returns:

        """
        if self.flag_connected:
            logging.debug(payload)
            return self.paho_client_mqtt.publish(self.device_to_cloud_topic, payload)
        else:
            logging.info('MQTT Disconnected')
            self.mqtt_start()
            return None

    def mqtt_publish_with_topic(self, topic, payload):
        """Publishes a mqtt message at a passed topic

        Args:
            topic: Message topic
            payload: Message Payload

        """
        logging.debug(topic)
        logging.debug(payload)
        self.paho_client_mqtt.publish(topic, payload)

    def mqtt_is_connected(self):
        """Returns the connection flag"""
        return self.flag_connected

    def handle_mqtt_messages(self, topic, payload):
        """This is where the job is done. This method will parse and execute different commands based on the content of
        the mqtt message.

        Args:
            topic: Message topic
            payload: Message payload

        """
        global decoded_payload
        logging.debug('handle_mqtt_messages')
        # handle messages from invoke topic
        if topic.startswith(self.invoke_base_topic):
            rid = topic.split('?$rid=')[1]
            method = topic.split('$iothub/methods/POST/')[1].split('/')[0]
            logging.debug('Rid: %s' % rid)
            logging.debug('Method: %s' % method)
            try:
                if method == 'ping':
                    decoded_payload = self.__decode_payload_as_non_compressed_json(payload)
                    logging.info("Received ping: {}".format(decoded_payload))
                    print("Received ping: {}".format(decoded_payload))
                    self.invoke_reply(200, rid, dumps({}))

            except Exception as e:
                logging.error('Failed to run command: %s' % e)
                resp = {'message': e}
                self.invoke_reply(500, rid, dumps(resp))

            try:
                if method == 'qrcode_app':
                    decoded_payload = self.__decode_payload_as_non_compressed_json(payload)
                    logging.info("Received ping: {}".format(decoded_payload))
                    print("Received ping: {}".format(decoded_payload))
                    self.invoke_reply(200, rid, dumps({}))

            except Exception as e:
                logging.error('Failed to run command: %s' % e)
                resp = {'message': e}
                self.invoke_reply(500, rid, dumps(resp))

            try:
                gera_qrconfirma()
                sleep(3)
                qrcode_conf()

            except Exception as e:
                logging.error('Failed to run command: %s' % e)
                resp = {'message': e}
                self.invoke_reply(500, rid, dumps(resp))

        return

    def __decode_payload_as_non_compressed_json(self, payload):
        """Transforms the payload (assuming it contains a non compressed json) from bytes object to dict object

        Args:
            payload (bytes): Json payload as bytes object

        Returns:
            dict: Json payload converted to a dict

        """
        payload_as_json_string = payload.decode()
        payload_as_json_dict = loads(payload_as_json_string)
        logging.debug('Payload: %s' % payload_as_json_dict)
        return payload_as_json_dict

    def invoke_reply(self, status_code, rid, payload):
        """Method used to publish the result of a previously received command

        Args:
            status_code (int): REST like status code
            rid (): Request Id used to identify witch request this response relates with
            payload (str): Message Payload


        """
        logging.debug('Invoke reply')
        topic = self.invoke_reply_topic
        topic = topic.replace('{status_code}', str(status_code))
        topic = topic.replace('{rid}', str(rid))
        logging.debug('Invoke reply topic: %s' % topic)
        logging.debug('Invoke reply message: %s' % payload)
        self.mqtt_publish_with_topic(topic, payload)


if __name__ == '__main__':
    my_mqtt_controller = MqttController("logicalis-eugeniostg-iothub.azure-devices.net", 8883)
    my_mqtt_controller.mqtt_start()
    MainApp().run()
