import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/dashboard/main_dashboard.dart';
import 'screens/setup/progress_setup_screen.dart';
import 'services/hermes_environment.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize Hermes environment
  await HermesEnvironment.initialize();
  
  runApp(const HermesTermuxApp());
}

class HermesTermuxApp extends StatelessWidget {
  const HermesTermuxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hermes-Termux',
      theme: HermesTheme.darkTheme,
      darkTheme: HermesTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const AppEntryGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppEntryGate extends StatelessWidget {
  const AppEntryGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SetupState>(
      stream: HermesEnvironment.setupStateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SplashScreen();
        }
                switch (snapshot.data!) {
          case SetupState.notStarted:
            return const ProgressSetupScreen();
          case SetupState.inProgress:
            return const ProgressSetupScreen();
          case SetupState.completed:
            return const MainDashboard();
          case SetupState.error:
            return SetupErrorScreen(error: HermesEnvironment.lastError);
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HermesTheme.backgroundDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud,
              size: 80,
              color: HermesTheme.primaryPurple,
            ),
            const SizedBox(height: 24),
            const Text(
              'Hermes-Termux',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: HermesTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Initializing...',
              style: TextStyle(
                fontSize: 14,
                color: HermesTheme.textSecondary,
              ),
            ),
          ],
        ),      ),
    );
  }
}

class SetupErrorScreen extends StatelessWidget {
  final String? error;
  
  const SetupErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HermesTheme.backgroundDark,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              const Text(
                'Setup Failed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HermesTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                error ?? 'Unknown error occurred',
                style: const TextStyle(
                  fontSize: 14,
                  color: HermesTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  HermesEnvironment.startSetup();
                },
                child: const Text('Retry Setup'),
              ),            ],
          ),
        ),
      ),
    );
  }
}
