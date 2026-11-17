import 'package:get/get.dart';
import '../models/game_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();

  // State Reaktif
  var isLoading = true.obs;
  var games = <GameModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGames();
  }

  Future<void> fetchGames() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _apiService.fetchGames();
      games.value = result;
    } catch (e) {
      errorMessage.value = 'Gagal Memuat Data. Periksa Koneksi Internet Anda!';
    } finally {
      isLoading.value = false;
    }
  }
}