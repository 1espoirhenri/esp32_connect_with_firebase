import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duy Hoàng - Trường Thịnh',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Duy Hoàng - Trường Thịnh'),
        ),
        body:
            const TemperatureHumidityWidget(title: 'Duy Hoàng - Trường Thịnh'),
      ),
    );
  }
}

class TemperatureHumidityWidget extends StatefulWidget {
  const TemperatureHumidityWidget({super.key, required this.title});
  final String title;
  @override
// ignore: library_private_types_in_public_api
  _TemperatureHumidityWidgetState createState() =>
      _TemperatureHumidityWidgetState();
}

class _TemperatureHumidityWidgetState extends State<TemperatureHumidityWidget> {
  bool _isDeviceOn = false;
  String _nhietdo = "";
  String _doamkk = "";
  String _doamdat = "";
  String _anhsang = "";
  int _count = 0;

  final ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    DatabaseReference nhietDo =
        FirebaseDatabase.instance.ref().child('TT_nhung/Nhietdo');
    nhietDo.onValue.listen((event) {
      setState(() {
        _nhietdo = event.snapshot.value.toString();
      });
    });
    DatabaseReference doamKK =
        FirebaseDatabase.instance.ref().child('TT_nhung/DoamKK');
    doamKK.onValue.listen((event) {
      setState(() {
        _doamkk = event.snapshot.value.toString();
      });
    });
    DatabaseReference doamDat =
        FirebaseDatabase.instance.ref().child('TT_nhung/Doamdat');
    doamDat.onValue.listen((event) {
      setState(() {
        _doamdat = event.snapshot.value.toString();
      });
    });
    DatabaseReference anhSang =
        FirebaseDatabase.instance.ref().child('TT_nhung/Anhsang');
    anhSang.onValue.listen((event) {
      setState(() {
        _anhsang = event.snapshot.value.toString();
      });
    });
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/hot.png', // Đường dẫn thư mục chứa tệp ảnh
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15),
            Text(
              'Nhiệt độ: $_nhietdo °C',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/humidity.png', // Đường dẫn thư mục chứa tệp ảnh
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15),
            Text(
              'Độ ẩm môi trường: $_doamkk %',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/humidity.png', // Đường dẫn thư mục chứa tệp ảnh
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15),
            Text(
              'Độ ẩm đất: $_doamdat %',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Image.asset(
              'assets/anhsang.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15),
            Text(
              'Ánh sáng: $_anhsang LUX',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        Image.asset(
          _isDeviceOn ? 'assets/bom.png' : 'assets/bom1.png',
          width: 150,
          height: 150,
        ),
        const SizedBox(width: 8), // Khoảng cách giữa hình ảnh và văn bản
        Text(
          _isDeviceOn ? 'Bật bơm' : 'Tắt bơm',
          style: const TextStyle(fontSize: 25),
        ),
        Switch(
          value: _isDeviceOn,
          onChanged: (bool value) {
            setState(() {
              _isDeviceOn = !_isDeviceOn;
              _isDeviceOn ? _count = 1 : _count = 0;
              ref.child('TT_nhung/bom').set(_count);
            });
          },
        ),
      ],
    );
  }
}
