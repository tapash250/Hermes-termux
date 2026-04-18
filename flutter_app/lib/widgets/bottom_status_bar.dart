import 'package:flutter/material.dart';

class BottomStatusBar extends StatelessWidget {
  final String profile, model, connectionStatus, language;
  
  const BottomStatusBar({
    Key? key,
    required this.profile,
    required this.model,
    required this.connectionStatus,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color(0xFF16213E),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(profile, style: TextStyle(color: Colors.grey[400], fontSize: 10)),
          const SizedBox(width: 10),
          Expanded(child: Text(model, style: TextStyle(color: Colors.grey[400], fontSize: 10), overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 10),
          Icon(Icons.circle, color: connectionStatus == 'Connected' ? Colors.green : Colors.red, size: 8),
          const SizedBox(width: 4),
          Text(connectionStatus, style: TextStyle(color: Colors.grey[400], fontSize: 10)),
        ],
      ),
    );
  }
}
