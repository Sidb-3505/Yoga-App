import 'package:flutter/material.dart';

class PlayerImageText extends StatelessWidget {
  final String? imagePath;
  final String? text;
  const PlayerImageText({super.key, this.imagePath, this.text});

  @override
  Widget build(BuildContext context) {
    print('Trying to load image: $imagePath');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imagePath != null) Image.asset(imagePath!, height: 250),
        const SizedBox(height: 30),
        if (text != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text!,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
