import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/game_model.dart';
import '../services/api_service.dart';

class DetailController extends GetxController {
  final ApiService _apiService = ApiService();
  final int gameId;

  DetailController({required this.gameId});

  // State Reaktif
  var isLoading = true.obs;
  var game = Rxn<GameModel>();
  var isOwned = false.obs;
  var errorMessage = ''.obs;

  final box = Hive.box('library'); 

  @override
  void onInit() {
    super.onInit();
    fetchDetail();
    checkOwnership();
  }

  // Ambil Detail dari API
  Future<void> fetchDetail() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _apiService.fetchGameDetail(gameId);
      game.value = result;
    } catch (e) {
      errorMessage.value = 'Gagal Memuat Detail Game.';
    } finally {
      isLoading.value = false;
    }
  }

  // Mengecek Apakah Game Sudah Ada di Library 
  void checkOwnership() {
    isOwned.value = box.containsKey(gameId);
  }

  // Toggle Tambah/Hapus dari Library
  void toggleLibrary() {
    if (game.value == null) return;

    if (box.containsKey(gameId)) {
      box.delete(gameId);
      isOwned.value = false;
      Get.snackbar(
        'Dihapus',
        'Game Dihapus dari Library',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
      );
    } else {
      box.put(gameId, game.value!.toJson());
      isOwned.value = true;
      Get.snackbar(
        'Berhasil',
        'Game Ditambahkan ke Library',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
      );
    }
  }
}