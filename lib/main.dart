import 'package:flutter/material.dart';
import 'package:voice_note_ai/models/ai_speech_text_model/ai_speech_text_model.dart';
import 'package:voice_note_ai/models/audio_model/audio_model.dart';
import './views/home_screen/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter();

   Hive.registerAdapter(AudioModelAdapter());
   Hive.registerAdapter(AiSpeechTextModelAdapter());

  await Hive.openBox<AudioModel>('AudioModelBox');
  await Hive.openBox<AiSpeechTextModel>('AiSpeechTextBox');
  

  runApp(const VoiceNoteAi());
}
class VoiceNoteAi extends StatelessWidget{
  const VoiceNoteAi({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(

      title: "Voice Note AI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),


      ),
      home: const HomeScreen(),

    );
  }
}

