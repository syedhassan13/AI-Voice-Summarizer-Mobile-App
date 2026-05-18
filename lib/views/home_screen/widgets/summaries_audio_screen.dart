import 'package:flutter/material.dart';
import 'package:voice_note_ai/controllers/ai_speech_text_controller.dart';
import 'package:voice_note_ai/models/ai_speech_text_model/ai_speech_text_model.dart';
import 'package:voice_note_ai/views/ai_summary_screen/ai_summary_screen.dart';


class SummariesAudioScreen extends StatelessWidget {
  final AiSpeechTextController aiSpeechTextController;
  final VoidCallback onUpdate;

  const SummariesAudioScreen({
    super.key,
    required this.aiSpeechTextController,
    required this. onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: aiSpeechTextController.aiSpeechList.length,
      itemBuilder: (context, index) {
        AiSpeechTextModel aiSpeechTextModel =
            aiSpeechTextController.aiSpeechList[index];

        return ListTile(
          leading: const Icon(Icons.description),
          //  Safe substring with length check
          title: Text(
            aiSpeechTextModel.audioText.length > 30
                ? "${aiSpeechTextModel.audioText.substring(0, 30)}..."
                : aiSpeechTextModel.audioText,
          ),
          subtitle: const Text("Tap to view summary"),
          //  Correct delete icon
          trailing: IconButton(
            onPressed: () async {
              await aiSpeechTextController.removeAudioSpeechText(index);
              onUpdate();
            },
            icon: const Icon(Icons.delete),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AiSummaryScreen(
                  aiSpeechTextModel: aiSpeechTextModel,
                ),
              ),
            );
          },
        );
      },
    );
  }
}