import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/game_model.dart';

class LibraryController extends GetxController {
  final box = Hive.box('library');

  // State reaktif
  var libraryGames = <GameModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLibrary();

    box.watch().listen((_) => loadLibrary());
  }

  void loadLibrary() {
    final List<GameModel> loaded = [];

    for (var key in box.keys) {
      final data = box.get(key);
      if (data != null) {
        try {
          // Konversi Map dari Hive ke GameModel
          loaded.add(_fromHive(key as int, Map<dynamic, dynamic>.from(data)));
        } catch (e) {
          debugPrint('Error load library: $e');
        }
      }
    }
    libraryGames.value = loaded;
  }

  // Helper Mengubah Map Hive ke GameModel
  GameModel _fromHive(int id, Map<dynamic, dynamic> data) {
    // Ambil Screenshots dan Ubah Balik dari Format List of Map ke List of String
    List<String> screenshots = [];
    if (data['screenshots'] != null) {
      final rawScreenshots = data['screenshots'] as List;
      screenshots = rawScreenshots.map((e) => e['image'].toString()).toList();
    }

    return GameModel(
      id: id,
      title: data['title']?.toString() ?? 'No Title',
      thumbnail: data['thumbnail']?.toString() ?? '',
      genre: data['genre']?.toString() ?? 'Unknown',
      platform: data['platform']?.toString() ?? 'Unknown',
      publisher: data['publisher']?.toString() ?? '-',
      developer: data['developer']?.toString() ?? '-',
      releaseDate: data['release_date']?.toString() ?? '-',
      description: data['description']?.toString() ?? '-',
      screenshots: screenshots,
    );
  }

  // Hapus Game dari Library
  void removeGame(int id) {
    box.delete(id);
    loadLibrary();

    Get.snackbar(
      'Dihapus',
      'Game Berhasil Dihapus dari Library',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
    );
  }
}