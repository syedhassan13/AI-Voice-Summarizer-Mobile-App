import 'package:hive/hive.dart';
part 'ai_speech_text_model.g.dart';


@HiveType(typeId: 1)
class AiSpeechTextModel extends HiveObject{

  @HiveField(0)
  String audioText;

  @HiveField(1)
  String audioSummaryText;
  
  AiSpeechTextModel({
    required this.audioText,
    required this.audioSummaryText,
  });





}