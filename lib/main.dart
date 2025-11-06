import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_biometric_change_detector/flutter_biometric_change_detector.dart';
import 'package:flutter_biometric_change_detector/status_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric Change Detector Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BiometricChangeDetectorDemo(),
    );
  }
}

class BiometricChangeDetectorDemo extends StatefulWidget {
  const BiometricChangeDetectorDemo({super.key});

  @override
  State<BiometricChangeDetectorDemo> createState() =>
      _BiometricChangeDetectorDemoState();
}

class _BiometricChangeDetectorDemoState
    extends State<BiometricChangeDetectorDemo> {
  String _statusMessage = 'Tap "Check Biometric Status" to begin';
  bool _isChecking = false;
  List<String> _changeHistory = [];
  AuthChangeStatus? _lastBiometricState;
  bool _isPolling = false;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _changeHistory = prefs.getStringList('biometric_history') ?? [];
      final storedStateIndex = prefs.getInt('last_biometric_state');
      if (storedStateIndex != null) {
        _lastBiometricState = AuthChangeStatus.values[storedStateIndex];
      }
    });
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('biometric_history', _changeHistory);
    if (_lastBiometricState != null) {
      await prefs.setInt('last_biometric_state', _lastBiometricState!.index);
    }
  }

  Future<void> _checkBiometricStatus({bool isPolling = false}) async {
    if (!isPolling) {
      setState(() {
        _isChecking = true;
        _statusMessage = 'Checking biometric status...';
      });
    }

    try {
      // Check biometric status
      final status = await FlutterBiometricChangeDetector.checkBiometric();

      if (status == null) {
        setState(() {
          _statusMessage =
              '❌ Unable to check biometric status.\n\nMake sure you have biometrics set up on your device.';
        });
        return;
      }

      // First time setup
      if (_lastBiometricState == null) {
        setState(() {
          _lastBiometricState = status;
          _statusMessage =
              '✅ Biometric baseline established!\n\nInitial State: ${_getStatusText(status)}\n\n'
              'Now try adding or removing a fingerprint/face ID from your device settings and check again.';
          _changeHistory.insert(
            0,
            '${DateTime.now().toString().substring(0, 19)} - Baseline established (State: ${_getStatusText(status)})',
          );
        });
        await _saveHistory();
      } else {
        // Compare with stored state
        if (status != _lastBiometricState) {
          setState(() {
            _statusMessage =
                '🚨 BIOMETRIC CHANGE DETECTED!\n\n'
                'Previous State: ${_getStatusText(_lastBiometricState!)}\n'
                'Current State: ${_getStatusText(status)}\n\n'
                '⚠️ User has added or removed fingerprint/face data!';
            _changeHistory.insert(
              0,
              '${DateTime.now().toString().substring(0, 19)} - ⚠️ Biometric changed! (${_getStatusText(_lastBiometricState!)} → ${_getStatusText(status)})',
            );
            _lastBiometricState = status;
          });
          await _saveHistory();
        } else {
          setState(() {
            _statusMessage =
                '✅ No biometric changes detected\n\n'
                'Current State: ${_getStatusText(status)}\n\n'
                '👍 Biometrics match the stored baseline';
          });
        }
      }
    } catch (e) {
      setState(() {
        _statusMessage =
            '❌ Error: ${e.toString()}\n\nMake sure you have biometrics set up on your device.';
      });
    } finally {
      if (!isPolling) {
        setState(() {
          _isChecking = false;
        });
      }
    }
  }

  void _startPolling() {
    if (_isPolling) return;

    setState(() {
      _isPolling = true;
    });

    // Poll every 3 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await _checkBiometricStatus(isPolling: true);
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    setState(() {
      _isPolling = false;
    });
  }

  Future<void> _forceRefresh() async {
    await _checkBiometricStatus();
  }

  String _getStatusText(AuthChangeStatus status) {
    switch (status) {
      case AuthChangeStatus.VALID:
        return 'Valid (Unchanged)';
      case AuthChangeStatus.CHANGED:
        return 'Changed';
      case AuthChangeStatus.INVALID:
        return 'Invalid';
      case AuthChangeStatus.UNKNOWN:
        return 'Unknown';
    }
  }

  Future<void> _resetBaseline() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_biometric_state');
    await prefs.remove('biometric_history');

    setState(() {
      _lastBiometricState = null;
      _changeHistory.clear();
      _statusMessage =
          'Baseline reset. Tap "Check Biometric Status" to establish a new baseline.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Change Detector'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Info Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.fingerprint,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'How it works',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'This app monitors biometric changes on your device. '
                      'When you add or remove a fingerprint or face ID, '
                      'the app will detect the change.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Status Card
            Card(
              elevation: 4,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_isPolling)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Auto-Checking',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _isChecking
                        ? const Center(child: CircularProgressIndicator())
                        : Text(
                            _statusMessage,
                            style: const TextStyle(fontSize: 16),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Action Buttons
            ElevatedButton.icon(
              onPressed: _isChecking ? null : _checkBiometricStatus,
              icon: const Icon(Icons.fingerprint),
              label: const Text('Check Biometric Status'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isChecking ? null : _forceRefresh,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Force Refresh'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(fontSize: 16),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isChecking
                        ? null
                        : (_isPolling ? _stopPolling : _startPolling),
                    icon: Icon(_isPolling ? Icons.stop : Icons.play_arrow),
                    label: Text(
                      _isPolling ? 'Stop Auto-Check' : 'Start Auto-Check',
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      textStyle: const TextStyle(fontSize: 16),
                      side: BorderSide(
                        color: _isPolling ? Colors.red : Colors.green,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isChecking ? null : _resetBaseline,
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset Baseline'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // History Card
            if (_changeHistory.isNotEmpty)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Change History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _changeHistory.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              _changeHistory[index],
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Instructions Card
            Card(
              elevation: 4,
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'Test Instructions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Tap "Check Biometric Status" to establish baseline\n'
                      '2. Go to device settings\n'
                      '3. Add or remove a fingerprint/face ID\n'
                      '4. Return to app and use "Force Refresh" or "Start Auto-Check"\n'
                      '5. The app will detect the change!\n\n'
                      '⚠️ Note: Adding biometrics is detected immediately. '
                      'Removing may take longer due to OS limitations. '
                      'Use Auto-Check (polls every 3s) for better detection.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
