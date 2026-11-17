import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';

class ApiService {
  static const String baseUrl = 'https://www.freetogame.com/api';

  // Ambil daftar game untuk Home
  Future<List<GameModel>> fetchGames() async {
    final response = await http.get(Uri.parse('$baseUrl/games'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => GameModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat daftar game');
    }
  }

  // Ambil detail game berdasarkan ID
  Future<GameModel> fetchGameDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/game?id=$id'));

    if (response.statusCode == 200) {
      return GameModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat detail game');
    }
  }
}