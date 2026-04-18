import 'package:flutter/material.dart';
import '../../services/hermes_environment.dart';
import '../../widgets/status_card.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/bottom_status_bar.dart';
import '../navigation/sidebar_navigation.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  bool _isRunning = false;
  String _model = 'qwen3-coder:480b-cloud';
  String _ollama = 'Checking...';

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final s = await HermesEnvironment.getHermesStatus();
    setState(() {
      _isRunning = s['isRunning'] ?? false;
      _model = s['model'] ?? _model;
      _ollama = (s['ollamaConnected'] ?? false) ? 'Connected' : 'Disconnected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text('Hermes-Termux'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
      ),
      drawer: const SidebarNavigation(),
      body: Column(
        children: [
          StatusCard(
            title: 'Hermes Agent',
            status: _isRunning ? 'Running' : 'Stopped',
            statusColor: _isRunning ? const Color(0xFF4ADE80) : Colors.grey,
            subtitle: '$_model via Ollama',
            localUrl: 'http://127.0.0.1:9119',
            onStop: () async {
              await HermesEnvironment.stopAgent();
              _refresh();
            },
            onViewLogs: () {},
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                QuickActionCard(icon: Icons.terminal, title: 'Terminal', subtitle: 'CLI Access', onTap: () {}, color: const Color(0xFF9B72E6)),
                QuickActionCard(icon: Icons.chat_bubble, title: 'Chat', subtitle: 'Start Chat', onTap: () {}, color: const Color(0xFFFF6B6B)),
                QuickActionCard(icon: Icons.school, title: 'Skills', subtitle: 'Capabilities', onTap: () {}, color: const Color(0xFF4ADE80)),
                QuickActionCard(icon: Icons.memory, title: 'Memory', subtitle: 'Context', onTap: () {}, color: const Color(0xFF60A5FA)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomStatusBar(
        profile: 'default',
        model: _model,
        connectionStatus: _ollama,
        language: 'English',
      ),
    );
  }
}
