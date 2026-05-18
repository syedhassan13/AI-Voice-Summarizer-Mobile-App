import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();

  Future<bool> init() async {
    return await _speech.initialize();
  }

  Future<void> startListening(Function(String) onResult) async {
    await _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
     listenOptions: SpeechListenOptions(
        listenMode: ListenMode.dictation,
        partialResults: true,
      ),
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

 Future<void> dispose() async {
  if (_speech.isListening) {
    await _speech.cancel();
  }
}

}
