class Fasilitas {
  final String nama;
  final String jenis;
  final String alamat;
  final String telepon;
  final double rating;
  final int ulasan;
  final double lat;
  final double lng;
  final String image;
  final List<String> layanan;
  final String deskripsi;

  Fasilitas({
    required this.nama,
    required this.jenis,
    required this.alamat,
    required this.telepon,
    required this.rating,
    required this.ulasan,
    required this.lat,
    required this.lng,
    required this.image,
    required this.layanan,
    required this.deskripsi,
  });
}