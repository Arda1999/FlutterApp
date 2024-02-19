import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class CompassApp extends StatefulWidget {
  @override
  _CompassAppState createState() => _CompassAppState();
}

class _CompassAppState extends State<CompassApp> {
  double azimuth = 0.0; // Pusula açısı
  final double kibleAngle = 45.0; // Kıble açısı (örnek olarak 45 derece)

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // Kullanıcının konumunu al
  _getLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      // Konum servisi kapalıysa kullanıcıyı ayarlara yönlendir
      bool serviceStatus = await Geolocator.openLocationSettings();
      if (!serviceStatus) {
        // Ayarlar açılmazsa veya kullanıcı izin vermezse uygulamaya devam edemez
        return;
      }
    }

    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Kullanıcı izin vermezse
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _updateAzimuth(position);
  }

  // Kıbleyi bul ve pusula açısını güncelle
  _updateAzimuth(Position position) {
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Mekke'nin koordinatları
    double meccaLat = 21.3891;
    double meccaLon = 39.8579;

    // Kıble açısını hesapla
    double latDiff = meccaLat - latitude;
    double lonDiff = meccaLon - longitude;
    double azimuth = atan2(lonDiff, latDiff) * (180 / pi);

    setState(() {
      this.azimuth = azimuth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/playstore.png',
              scale: 12,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.004,
            ),
            const Text(
              'Zikirmatik',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: KiblePainter(azimuth, kibleAngle),
              child: Image.asset(
                'assets/images/comhiclipartyaslu-removebg-preview.png',
                width: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Kıble Açısı: ${azimuth.toStringAsFixed(2)}°',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class KiblePainter extends CustomPainter {
  final double azimuth;
  final double kibleAngle;

  KiblePainter(this.azimuth, this.kibleAngle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    double radians = (azimuth - kibleAngle) * (pi / 180);

    double x = centerX + cos(radians) * 80; // Uzunluğu ayarlayabilirsiniz
    double y = centerY + sin(radians) * 80; // Uzunluğu ayarlayabilirsiniz

    canvas.drawLine(Offset(centerX, centerY), Offset(x, y), paint);
    canvas.drawCircle(Offset(x, y), 8, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
