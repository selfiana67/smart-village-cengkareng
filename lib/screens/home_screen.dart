import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/fasilitas.dart';
import 'detail_screen.dart';
import 'list_screen.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedKategori = 'Semua';
  final List<String> kategori = ['Semua', 'Rumah Sakit', 'Puskesmas', 'Klinik', 'Apotek'];

  List<Fasilitas> get filtered {
    if (selectedKategori == 'Semua') return daftarFasilitas;
    return daftarFasilitas.where((f) => f.jenis == selectedKategori).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Smart Village', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Cengkareng, Jakarta Barat', style: TextStyle(fontSize: 12)),
          ],
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  Icon(Icons.local_hospital, color: Colors.white, size: 40),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Butuh Bantuan Cepat?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('Cari fasilitas kesehatan terdekat dari lokasi kamu.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ListScreen())),
                    icon: const Icon(Icons.list),
                    label: const Text('Lihat Semua List'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen())),
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Buka Peta'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: kategori.map((k) {
                  final aktif = k == selectedKategori;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(k),
                      selected: aktif,
                      onSelected: (_) => setState(() => selectedKategori = k),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Fasilitas Terdekat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ...filtered.map((f) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(f.image, width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: Colors.blue.shade100, child: const Icon(Icons.local_hospital))),
                ),
                title: Text(f.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${f.jenis} • ${f.rating} ⭐ (${f.ulasan})\n${f.alamat}', maxLines: 2, overflow: TextOverflow.ellipsis),
                isThreeLine: true,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(fasilitas: f))),
              ),
            )),
          ],
        ),
      ),
    );
  }
}