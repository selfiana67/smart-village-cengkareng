import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/fasilitas.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String query = '';
  String filterJenis = 'Semua';

  List<Fasilitas> get hasil {
    return daftarFasilitas.where((f) {
      final cocokNama = f.nama.toLowerCase().contains(query.toLowerCase());
      final cocokJenis = filterJenis == 'Semua' || f.jenis == filterJenis;
      return cocokNama && cocokJenis;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Fasilitas'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: InputDecoration(
                hintText: 'Cari RS, Puskesmas, Apotek...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Semua', 'Rumah Sakit', 'Puskesmas', 'Klinik', 'Apotek'].map((j) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ChoiceChip(
                    label: Text(j),
                    selected: filterJenis == j,
                    onSelected: (_) => setState(() => filterJenis = j),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: hasil.isEmpty
                ? const Center(child: Text('Tidak ditemukan'))
                : ListView.builder(
                    itemCount: hasil.length,
                    itemBuilder: (ctx, i) {
                      final f = hasil[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(f.image, width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: Colors.blue.shade100, child: const Icon(Icons.local_hospital))),
                          ),
                          title: Text(f.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${f.jenis} • ${f.rating} ⭐\n${f.alamat}', maxLines: 2, overflow: TextOverflow.ellipsis),
                          isThreeLine: true,
                          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(fasilitas: f))),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}