import 'package:flutter/material.dart';
import '../../services/hermes_environment.dart';
import '../../utils/theme.dart';

class ProgressSetupScreen extends StatelessWidget {
  const ProgressSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HermesTheme.backgroundDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: HermesTheme.primaryPurple),
            const SizedBox(height: 20),
            const Text('Installing Hermes Agent...', style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => HermesEnvironment.startSetup(),
              child: const Text('Start Setup'),
            ),
          ],
        ),
      ),
    );
  }
}
