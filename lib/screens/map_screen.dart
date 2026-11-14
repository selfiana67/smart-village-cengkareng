import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../data/dummy_data.dart';
import 'detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Titik tengah Cengkareng
  final LatLng pusat = const LatLng(-6.1412, 106.7185);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta & Geofencing'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: pusat,
              initialZoom: 13.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.smart_village_fix',
              ),
              // Lingkaran Geofencing 2 KM
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: pusat,
                    radius: 2000, // 2 KM dalam meter
                    color: Colors.blue.withOpacity(0.15),
                    borderColor: Colors.blue,
                    borderStrokeWidth: 2,
                  ),
                ],
              ),
              // Pin semua fasilitas
              MarkerLayer(
                markers: daftarFasilitas.map((f) {
                  return Marker(
                    point: LatLng(f.lat, f.lng),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(fasilitas: f))),
                      child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          // Info di bawah
          Positioned(
            left: 12, right: 12, bottom: 12,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)]),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Geofencing Aktif - Radius 2 KM', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Kamu berada di dalam zona Cengkareng. Tap pin merah untuk lihat detail fasilitas.', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}