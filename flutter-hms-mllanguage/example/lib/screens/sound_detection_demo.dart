/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0
        
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:huawei_ml_language/huawei_ml_language.dart';

import '../utils/demo_utils.dart';

class SoundDetectionDemo extends StatefulWidget {
  const SoundDetectionDemo({Key? key}) : super(key: key);

  @override
  _SoundDetectionDemoState createState() => _SoundDetectionDemoState();
}

class _SoundDetectionDemoState extends State<SoundDetectionDemo> {
  late MLSoundDetector detector;
  List _events = ['Initial event'];

  @override
  void initState() {
    detector = MLSoundDetector();
    detector.setSoundDetectListener(onDetection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sound Detection Demo')),
      body: Column(
        children: [
          recognitionButton(_start, text: 'Start'),
          recognitionButton(_stop, text: 'Stop'),
          recognitionButton(_destroy, text: 'Destroy'),
          Expanded(
              child: ListView.builder(
            itemCount: _events.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_events[index]),
              );
            },
          ))
        ],
      ),
    );
  }

  void _start() async {
    final isStarted = await detector.start();
    setState(() => _events.add('is started: $isStarted'));
  }

  void _stop() {
    try {
      detector.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void _destroy() {
    try {
      detector.destroy();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  void onDetection({int? result, int? errCode}) {
    if (result != null) {
      setState(() => _events.add('result code: $result'));
    } else {
      setState(() => _events.add('error code: $errCode'));
    }
  }
}
