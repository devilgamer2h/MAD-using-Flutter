import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(debugShowCheckedModeBanner: false, home: StopwatchApp()),
);

class StopwatchApp extends StatefulWidget {
  @override
  State<StopwatchApp> createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  final _sw = Stopwatch();
  Timer? _t;

  void _act(String a) {
    if (a == 'Start' && !_sw.isRunning) {
      _sw.start();
      _t = Timer.periodic(Duration(milliseconds: 50), (_) => setState(() {}));
    } else if (a == 'Stop') {
      _sw.stop();
      _t?.cancel();
    } else if (a == 'Reset') {
      _sw.reset();
      setState(() {});
    }
  }

  String _time() {
    final ms = _sw.elapsedMilliseconds;
    return "${(ms ~/ 3600000).toString().padLeft(2, '0')}:"
        "${((ms ~/ 60000) % 60).toString().padLeft(2, '0')}:"
        "${((ms ~/ 1000) % 60).toString().padLeft(2, '0')}."
        "${((ms % 1000) ~/ 10).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Stopwatch')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _time(),
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _act('Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Start'),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () => _act('Stop'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Stop'),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () => _act('Reset'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
