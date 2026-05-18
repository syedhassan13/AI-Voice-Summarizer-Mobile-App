
import 'package:flutter_sound/flutter_sound.dart';
import '../models/audio_model/audio_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class AudioService {
  final FlutterSoundRecorder _recorder =  FlutterSoundRecorder();
   final FlutterSoundPlayer _player = FlutterSoundPlayer();
   final durationPlayer = AudioPlayer();
   late Box<AudioModel> audioModelBox;

   

  bool isRecording = false;
  bool isPaused = false;

  //Initialoze Recorder
  Future<void> init() async{
    await _recorder.openRecorder();
    await _player.openPlayer();
    audioModelBox = Hive.box<AudioModel>('AudioModelBox');

  }
   Future<void> startRecording(String currentFilePath) async {

    await _recorder.startRecorder(
      toFile: currentFilePath,
      codec: Codec.aacADTS,
    );

    isRecording = true;
    isPaused = false;
  }

  /// Pause or Resume
  Future<void> togglePause() async {
    if (isPaused) {
      await _recorder.resumeRecorder();
      isPaused = false;
    } else {
      await _recorder.pauseRecorder();
      isPaused = true;
    }
  }

  /// Stop recording
  Future<void> stopRecording(String?currentFilePath,List<AudioModel> audioList) async {
    // await _speechService.stopListening();
   await _recorder.stopRecorder();




    if(currentFilePath!=null){

      await durationPlayer.setFilePath(currentFilePath); 
     
  

       final audio = AudioModel(
      path: currentFilePath,
      recordingDuration: formatDuration(durationPlayer.duration),
  
      
    );

    // ✅ Add ONCE to Hive
    await audioModelBox.add(audio);

    // ✅ SAME object goes to UI list
    audioList.add(audio);
       
    }
    isRecording = false;
    isPaused = false;
    
    
  }

   /// Play / Pause audio
  Future<void> play(AudioModel audio) async {
    if (_player.isPlaying) {
      await _player.stopPlayer();
      audio.isPlaying = false;
     
    } else {
      await _player.startPlayer(
        fromURI: audio.path,
        whenFinished: () {
          audio.isPlaying = false;
          
        },
      );
      audio.isPlaying = true;
      
    }
  }
  
  String formatDuration(Duration? duration) {
  if (duration == null) return "0:00";
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$seconds"; // mm:ss format
}

  


  Future<void> dispose() async{
    _recorder.closeRecorder();
    await durationPlayer.dispose(); 
    _player.closePlayer();
  }


}