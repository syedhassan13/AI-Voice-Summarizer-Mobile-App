import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '../models/audio_model/audio_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class StorageService {
  final durationPlayer = AudioPlayer();
  late Box<AudioModel> audioModelBox;

    Future<String> getAudioPath() async {
    final dir = await getApplicationDocumentsDirectory();
    
      return '${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.aac';
  }



Future<void> loadAudios(List<AudioModel> audioList) async {
  audioModelBox = Hive.box<AudioModel>('AudioModelBox');

  audioList.clear();

  for (final audio in audioModelBox.values) {
    // optional: check if file still exists
    if (File(audio.path).existsSync()) {
      audioList.add(audio);
    }
    else{
       await audio.delete(); 
    }
  }
}


 Future<void> removeAudio(int index,List<AudioModel>audioList) async {
   final audio = audioList[index];
  final file = File(audioList[index].path);
  if (await file.exists()) {
    await file.delete();
  }
   await audio.delete();
  audioList.removeAt(index);
}



  String formatDuration(Duration? duration) {
  if (duration == null) return "0:00";
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$seconds"; // mm:ss format
}


 Future<void> dispose() async{
   
    await durationPlayer.dispose(); 
   
  }
}
