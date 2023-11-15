import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:typed_data';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  int clickContador = 0;
  String humedad = '0';
  BluetoothConnection? connection;

  @override
  void initState() {
    super.initState();
    // Llama a la función connectToDevice al iniciar el widget
    connectToDevice();
  }

  Future<BluetoothDevice?> _showDeviceListDialog(List<BluetoothDevice> devices) async {
    return showDialog<BluetoothDevice>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccione un dispositivo Bluetooth'),
          content: Column(
            children: devices.map((device) {
              return ListTile(
                title: Text(device.name!),
                subtitle: Text(device.address),
                onTap: () {
                  Navigator.of(context).pop(device); // Devuelve el dispositivo seleccionado
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void connectToDevice() async {
    try {
      List<BluetoothDevice> bondedDevices =
          await FlutterBluetoothSerial.instance.getBondedDevices();

      if (bondedDevices.isEmpty) {
        // Maneja el caso en que no hay dispositivos emparejados
        //print('No hay dispositivos emparejados');
        return;
      }

      // Muestra el diálogo para que el usuario seleccione un dispositivo
      BluetoothDevice? selectedDevice = await _showDeviceListDialog(bondedDevices);

      if (selectedDevice != null) {
        connection = await BluetoothConnection.toAddress(selectedDevice.address);

        connection!.input!.listen((Uint8List data) {
          String decodedData = ascii.decode(data);

          // Aquí puedes procesar o mostrar los datos recibidos según tus necesidades
          // Por ejemplo, puedes actualizar la interfaz de usuario con el valor de humedad.
          if (decodedData != humedad) {
            setState(() {
              humedad = decodedData;
            });
          }

        });
      }
    } catch (exception) {
      print('Cannot connect');
    }
  }

  @override
  Widget build(BuildContext context) {

    double humedadDouble = double.parse(humedad);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plant-Blue v1.0',
          style: TextStyle(fontWeight: FontWeight.w200,fontSize: 30, color: Color.fromARGB(255, 36, 82, 38)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 90,),
            if(humedadDouble>=0 && humedadDouble <= 30)
              Text('Bomba Encendida!!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100)),
            if(humedadDouble>=0 && humedadDouble <= 30)
              Image.asset('lib/assets/azul_gota.png', height: 100.0),
            SizedBox(height: 30,),
            // PLANTA
            Image.asset('lib/assets/plantita_v1.png', height: 100.0),
            Text(humedad, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100)),
            const Text('% Humidity', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100)),
            SizedBox(height: 50,),

            if(humedadDouble>30)

              Text('Bomba Apagada - Humedad Óptima', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
            if(humedadDouble>30)
              Image.asset('lib/assets/roja_gota.png', height: 100.0),

             
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Asegúrate de cerrar la conexión Bluetooth y liberar recursos al destruir el widget.
    connection?.finish();
    super.dispose();
  }
}
