import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/library_controller.dart';
import '../models/game_model.dart';
import 'detail_page.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LibraryController controller = Get.put(LibraryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Library Anda',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        // Apabila Masih Kosong 
        if (controller.libraryGames.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Library Masih Kosong',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tambahkan Game dari Halaman Detail',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // List View 
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: controller.libraryGames.length,
          itemBuilder: (context, index) {
            final GameModel game = controller.libraryGames[index];
            return _libraryCard(context, controller, game);
          },
        );
      }),
    );
  }

  Widget _libraryCard(
    BuildContext context,
    LibraryController controller,
    GameModel game,
  ) {
    return GestureDetector(
      onTap: () {
        // Klik Menuju Detail Page
        Get.to(() => DetailPage(gameId: game.id));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        color: const Color(0xFF1E1E1E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 115,
          child: Row(
            children: [
              // Gambar 
              SizedBox(
                width: 120,
                height: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: game.thumbnail,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: const Color(0xFF2A2A2A),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: const Color(0xFF2A2A2A),
                    child: const Icon(Icons.gamepad, color: Colors.grey),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Judul
                      Text(
                        game.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Genre 
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF333333),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          game.genre,
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Platform
                      Text(
                        game.platform,
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              // Tombol Delete 
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                tooltip: 'Hapus dari Library',
                onPressed: () {
                  // Konfirmasi Sebelum Hapus 
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: const Color(0xFF1E1E1E),
                      title: const Text('Hapus Game?', style: TextStyle(color: Colors.white)),
                      content: Text(
                        '"${game.title}" Akan Dihapus dari Daftar Library.',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('Batal', style: TextStyle(color: Colors.grey)),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            controller.removeGame(game.id);
                          },
                          child: const Text(
                            'Hapus',
                            style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}