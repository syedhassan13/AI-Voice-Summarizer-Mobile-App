import 'package:hive/hive.dart';
part 'audio_model.g.dart';



@HiveType(typeId: 0)
class AudioModel extends HiveObject {

  @HiveField(0)
  String path;

  @HiveField(1)
  String recordingDuration;

  @HiveField(2)
  bool isPlaying;


  AudioModel({
    required this.path,
    required this.recordingDuration,
    this.isPlaying = false,
  });
  
}
