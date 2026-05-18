import 'package:flutter/material.dart';
import 'package:voice_note_ai/models/ai_speech_text_model/ai_speech_text_model.dart';

class AiSummaryScreen extends StatelessWidget {
  final AiSpeechTextModel aiSpeechTextModel;

  const AiSummaryScreen({
    super.key,
    required this.aiSpeechTextModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Summary"),
        backgroundColor: Theme. of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(  // Add scroll for long text
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Audio Text Section
              const Text(
                "Audio Text:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight. bold,
                ),
              ),
              const SizedBox(height: 10),
              //  Fixed string interpolation
              Text(
                aiSpeechTextModel.audioText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight. w400,
                ),
              ),
              const SizedBox(height:  30),

              // AI Summary Section
              const Text(
                "AI Summary:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight. bold,
                ),
              ),
              const SizedBox(height: 10),
              // Fixed string interpolation
              Text(
                aiSpeechTextModel.audioSummaryText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight:  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}