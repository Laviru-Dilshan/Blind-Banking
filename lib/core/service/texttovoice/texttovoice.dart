import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}
