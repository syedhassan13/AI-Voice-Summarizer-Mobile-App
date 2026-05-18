import 'package:flutter/material.dart';
import 'package:voice_note_ai/models/ai_speech_text_model/ai_speech_text_model.dart';
import 'package:voice_note_ai/services/permission_service.dart';

import '../services/speech_service.dart';
import 'ai_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class AiSpeechTextController {

  SpeechService speechService = SpeechService();
  List<AiSpeechTextModel> aiSpeechList =[];

  late Box<AiSpeechTextModel> aiSpeechTextBox;

   AiController aiController = AiController();

   String _liveText = "";
   String _finalText = "";
   bool isResumed = false;
   bool isPaused = false;
   bool _permissionGranted = false;

   PermissionService permissionService = PermissionService();


  Future<void> init() async{

     await speechService.init();
     aiSpeechTextBox = Hive.box<AiSpeechTextModel>('AiSpeechTextBox');
  }

  Future<void> startListeningAudio()async{
    
    isResumed = true;
    isPaused = false;
   
     await speechService.startListening((text) {
     _liveText = text;
   });


  }

  Future<void> stopListeningAudio() async{

    
    await speechService.stopListening();
    isResumed = false;
    isPaused = false;
  }

  Future<void> togglePauseListeningAudio() async {
  if (!isPaused) {
    // Pause
    await speechService.stopListening();
    _finalText += " $_liveText";
    _liveText = "";
    isPaused = true;
    
  } else {
    // Resume
    await speechService.startListening((text) {
      _liveText = text;
    });
    isPaused = false;
    isResumed = true;
  }
}

  Future<bool> requestPermission() async {
  if (_permissionGranted) return true;
  _permissionGranted = await permissionService.requestPermission();
  return _permissionGranted;
}
  Future<void> loadAudiosSpeechText() async {
 
 

  aiSpeechList.clear();

  for (final audio in aiSpeechTextBox.values) {
   
   
      aiSpeechList.add(audio);
    
   
  }
}

 Future<void> removeAudioSpeechText(int index) async {
   final audioText = aiSpeechList[index];
 
 
   await audioText.delete();
  aiSpeechList.removeAt(index);
}



  Future<void> handleFabPressed() async{
    if(!isResumed){
      bool granted = await requestPermission();
      
      if (!granted) return;
    
      await startListeningAudio();
    }
    else{
      await togglePauseListeningAudio();
    }

  }
  Future<void> handleFabLongPress() async {
  if (isResumed) {
    await stopListeningAudio();

    // Combine _finalText and _liveText
    String fullText = _finalText. isNotEmpty 
        ? "$_finalText $_liveText". trim() 
        : _liveText. trim();

    if (fullText.isEmpty) {
      // Handle empty text case
      _finalText = "";
      _liveText = "";
      return;
    }

  
    //  Show loading indicator (optional)
    String summaryAudio = "Generating summary...";

    try {
      // Generate summary from FULL text (not just _liveText)
      summaryAudio = await aiController. generateSummary(fullText);
      debugPrint("Summary generated:  $summaryAudio");
    } catch (e) {
      debugPrint("Error generating summary: $e");
      summaryAudio = "Error generating summary";
    }


    final speechText = AiSpeechTextModel(
      audioText: fullText,  // Use combined text
      audioSummaryText: summaryAudio,
    );

    await aiSpeechTextBox.add(speechText);
    aiSpeechList.add(speechText);

    // Reset
    _finalText = "";
    _liveText = "";
  }
}

  Future<void> dispose() async{
    await speechService.dispose();

  }


}