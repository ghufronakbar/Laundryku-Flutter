import 'package:flutter/material.dart';

class Colors {
  // Warna utama dan sekunder
  static const primary = Color(0xFF9D26B4); // Ungu
  static const secondary = Color(0xFFfef7ff); // Latar belakang terang
  static const white = Color(0xFFFFFFFF); // Putih
  static const err = Color(0xFFEC4C4C); // Merah untuk error

  // Warna berdasarkan status
  static const pending = Color(0xFFFFC107); // Kuning, menunjukkan menunggu
  static const cancelled = Color(0xFFEC4C4C); // Merah, menunjukkan dibatalkan
  static const expired = Color(0xFF9E9E9E); // Abu-abu, menunjukkan kadaluarsa
  static const paid = Color(0xFF4CAF50); // Hijau, menunjukkan berhasil/dibayar
}
