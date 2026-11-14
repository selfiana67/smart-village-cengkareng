import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/fasilitas.dart';

class DetailScreen extends StatelessWidget {
  final Fasilitas fasilitas;
  const DetailScreen({super.key, required this.fasilitas});

  Future<void> _bukaMaps(double lat, double lng, String nama) async {
    final Uri url = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&destination_place_id=$nama&travelmode=driving');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Gagal buka Maps: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final f = fasilitas;
    return Scaffold(
      appBar: AppBar(title: Text(f.nama), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(f.image, height: 220, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 220, color: Colors.blue.shade100, child: const Icon(Icons.local_hospital, size: 60))),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(f.nama, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${f.jenis} • ${f.rating} ⭐ (${f.ulasan} ulasan)', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 12),
                  Row(children: [const Icon(Icons.location_on, size: 18, color: Colors.red), const SizedBox(width: 6), Expanded(child: Text(f.alamat))]),
                  const SizedBox(height: 8),
                  Row(children: [const Icon(Icons.phone, size: 18, color: Colors.green), const SizedBox(width: 6), Text(f.telepon)]),
                  const SizedBox(height: 16),
                  const Text('Tentang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text(f.deskripsi),
                  const SizedBox(height: 16),
                  const Text('Layanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: f.layanan.map((l) => Chip(label: Text(l), backgroundColor: Colors.blue.shade50)).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _bukaMaps(f.lat, f.lng, f.nama),
                      icon: const Icon(Icons.navigation),
                      label: const Text('Petunjuk Arah (Geofencing)'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Akan membuka Google Maps dan memberi rute dari lokasi kamu ke fasilitas ini.', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}