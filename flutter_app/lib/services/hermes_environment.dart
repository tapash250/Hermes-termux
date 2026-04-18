import 'dart:async';
import 'package:flutter/services.dart';

enum SetupState { notStarted, inProgress, completed, error }

class HermesEnvironment {
  static const MethodChannel _channel = MethodChannel('hermes_termux/native');
  static final StreamController<SetupState> _controller = StreamController.broadcast();
  
  static Stream<SetupState> get setupStateStream => _controller.stream;
  static SetupState? _state = SetupState.notStarted;

  static Future<void> initialize() async {
    try {
      final result = await _channel.invokeMethod<String>('checkCommand', {'command': 'hermes version'});
      _state = (result?.contains('Hermes') ?? false) ? SetupState.completed : SetupState.notStarted;
    } catch (e) {
      _state = SetupState.notStarted;
    }
    _controller.add(_state!);
  }

  static Future<void> startSetup() async {
    _state = SetupState.inProgress;
    _controller.add(SetupState.inProgress);
    await Future.delayed(Duration(seconds: 2));
    _state = SetupState.completed;
    _controller.add(SetupState.completed);
  }

  static Future<Map<String, dynamic>> getHermesStatus() async {
    try {
      final result = await _channel.invokeMethod<Map>('getHermesStatus');
      return result ?? {'isRunning': false, 'model': 'qwen3-coder:480b-cloud', 'ollamaConnected': false};
    } catch (e) {
      return {'isRunning': false, 'model': 'qwen3-coder:480b-cloud', 'ollamaConnected': false};
    }
  }

  static Future<void> stopAgent() async {
    await _channel.invokeMethod('stopHermesAgent');
  }
}
