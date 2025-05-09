import 'package:flutter/material.dart';

class ImdSubscoreInfo {
  final IconData icon; // The icon for the ListTile
  final String title; // The title for the ListTile
  final String dataKey; // The key to access the data in ImdResponse (e.g., 'incomeDecile')
  final String detailTitle; // The title for the modal
  final String detailText; // The text content for the modal

  ImdSubscoreInfo({
    required this.icon,
    required this.title,
    required this.dataKey,
    required this.detailTitle,
    required this.detailText,
  });
}

// Widget for the detail content in the modal bottom sheet
class ImdSubscoreDetail extends StatelessWidget {
  const ImdSubscoreDetail({
    Key? key,
    required this.title,
    required this.detailText,
  }) : super(key: key);

  final String title;
  final String detailText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView( // Allow scrolling within the bottom sheet if text is long
              child: Text(
                "$detailText Note that the lower the score, the higher the level of deprivation.",
                style: const TextStyle(fontSize: 14, fontFamily: 'Montserrat'),
              ),
            ),
          ),
          const Text(
            "Source: English indices of deprivation 2019, Ministry of Housing, Communities & Local Government",
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              fontFamily: 'Montserrat',
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}