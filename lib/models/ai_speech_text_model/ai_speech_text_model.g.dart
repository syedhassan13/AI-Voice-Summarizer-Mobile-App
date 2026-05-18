// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_speech_text_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AiSpeechTextModelAdapter extends TypeAdapter<AiSpeechTextModel> {
  @override
  final int typeId = 1;

  @override
  AiSpeechTextModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AiSpeechTextModel(
      audioText: fields[0] as String,
      audioSummaryText: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AiSpeechTextModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.audioText)
      ..writeByte(1)
      ..write(obj.audioSummaryText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AiSpeechTextModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
