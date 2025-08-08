import 'package:flutter/material.dart';
import 'package:yoga_app/screens/countdown_screen.dart';
import '../models/yoga_app_model.dart';

class PreviewScreen extends StatelessWidget {
  final YogaAppModel model;
  const PreviewScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final sequences = model.sequence ?? [];
    final images = model.assets?.images;

    final filteredScripts = <Map<String, dynamic>>[];

    for (var sequence in sequences) {
      for (var s in sequence.script ?? []) {
        if (['base', 'cat', 'cow'].contains(s.imageRef?.toLowerCase())) {
          filteredScripts.add({
            'imageRef': s.imageRef?.toLowerCase(),
            'text': s.text,
            'start': s.startSec,
            'end': s.endSec,
          });
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Light teal
      appBar: AppBar(
        backgroundColor: const Color(0xFF00897B), // Teal dark
        title: Text(
          model.metadata?.title ?? "Session Preview",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: SafeArea(
              child: ListView.builder(
                itemCount: filteredScripts.length,
                itemBuilder: (context, index) {
                  final s = filteredScripts[index];
                  String? img;
                  switch (s['imageRef']) {
                    case 'base':
                      img = images?.base;
                      break;
                    case 'cat':
                      img = images?.cat;
                      break;
                    case 'cow':
                      img = images?.cow;
                      break;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Container
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB2DFDB),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/images/$img',
                            fit: BoxFit.contain,
                            errorBuilder: (ctx, error, _) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Text Container
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              s['text'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF004D40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Start Session Button
          Positioned(
            left: 20,
            right: 20,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CountdownScreen(
                      scripts: filteredScripts,
                      model: model,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00796B),
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              child: const Text(
                'Start Session',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
