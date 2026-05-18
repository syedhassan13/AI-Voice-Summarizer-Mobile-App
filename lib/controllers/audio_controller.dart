
import '../models/audio_model/audio_model.dart';
import 'package:just_audio/just_audio.dart';
import '../services/permission_service.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';


class AudioController {


   final durationPlayer = AudioPlayer();


  List<AudioModel> audioList = [];

  bool isRecording = false;
  bool isPaused = false;
  String? currentFilePath;


  //Services objects
   PermissionService permissionService = PermissionService();
   AudioService audioService = AudioService();
   StorageService storageService = StorageService();
  


  //Initialoze Recorder
  Future<void> init() async{
   
   await audioService.init();

  }
  //Ask mic permission
  Future<bool> requestPermission()async{
 
    return await permissionService.requestPermission();
  }
    /// Start recording
  Future<void> startRecording() async {
 
    currentFilePath = await storageService.getAudioPath();

   
   
   await audioService.startRecording(currentFilePath!);
    isRecording = audioService.isRecording;
    isPaused = audioService.isPaused;
  }

  /// Pause or Resume
  Future<void> togglePause() async {
    if(!isRecording) return;
  
    await audioService.togglePause();
    isRecording = audioService.isRecording;
    isPaused = audioService.isPaused;
  }

  /// Stop recording
  Future<void> stopRecording() async {
   
    if(currentFilePath!=null){
    await audioService.stopRecording(currentFilePath!,audioList);
     isRecording = audioService.isRecording;
    isPaused = audioService.isPaused;
    }
    
    currentFilePath = null;
    isRecording = false;
    isPaused = false;
  }

   /// Play / Pause audio
  Future<void> play(AudioModel audio) async {
  
    await audioService.play(audio);
  
   
  }
  


  Future<void> loadAudios() async {
 
  await storageService.loadAudios(audioList);
 
}

 Future<void> removeAudio(int index) async {

  await storageService.removeAudio(index, audioList);
 
 
}


Future<void> handleFabPressed() async {
    if (!isRecording) {
      bool granted = await requestPermission();
      
      if (!granted) return;

      await startRecording();
    } else {
    
      await togglePause();
    }
  

  
  }

  Future<void> handleFabLongPress() async {
    if (isRecording) {
      await stopRecording();
    
    
    }
  }


  
  Future<void> dispose() async{

    await audioService.dispose();
    await storageService.dispose();
    
  
  }
}
