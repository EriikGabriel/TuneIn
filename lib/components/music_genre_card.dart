import 'package:flutter/material.dart';

class MusicGenreCard extends StatelessWidget {
  final String genreName;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const MusicGenreCard({
    super.key,
    required this.genreName,
    this.icon = Icons.music_note,
    this.backgroundColor = const Color(0xFF1E1E1E),
    this.textColor = Colors.white,
    this.borderColor = const Color(0xFF3A3A3A),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black26,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 48),
          Text(
            genreName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
