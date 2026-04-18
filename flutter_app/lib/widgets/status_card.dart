import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/theme.dart';

class StatusCard extends StatelessWidget {
  final String title, status, subtitle, localUrl;
  final Color statusColor;
  final VoidCallback onStop, onViewLogs;
  
  const StatusCard({
    Key? key,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.subtitle,
    required this.localUrl,
    required this.onStop,
    required this.onViewLogs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HermesTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D3748)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cloud, color: HermesTheme.primaryPurple, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: HermesTheme.textPrimary)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        Text(status, style: TextStyle(fontSize: 14, color: statusColor, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: HermesTheme.textSecondary)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Text(localUrl, style: const TextStyle(fontSize: 12, color: HermesTheme.textSecondary, fontFamily: 'monospace'))),
              IconButton(
                icon: const Icon(Icons.copy, size: 18),
                color: HermesTheme.textSecondary,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: localUrl));
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onStop,
                  icon: const Icon(Icons.stop, size: 18),
                  label: const Text('Stop Agent'),
                  style: ElevatedButton.styleFrom(backgroundColor: HermesTheme.primaryPink),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onViewLogs,
                  icon: const Icon(Icons.bug_report, size: 18),
                  label: const Text('View Logs'),
                  style: OutlinedButton.styleFrom(foregroundColor: HermesTheme.textPrimary, side: const BorderSide(color: HermesTheme.primaryPurple)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
