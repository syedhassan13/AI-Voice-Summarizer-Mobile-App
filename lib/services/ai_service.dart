import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiService {
  static const String _apiKey = "AIzaSyA6EkLmWGfTy8Y9xW10mHqiC6rgFwVGGM0";

  late final GenerativeModel _model;

  AiService() {
    log("🟢 AiService initialized");

    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
    );
  }

  Future<String> summarize(String text) async {
    log("🟡 summarize() called");

    if (text.trim().isEmpty) {
      log("⚠️ Empty input text");
      return "No text to summarize";
    }

    log("📄 Input length: ${text.length}");

    try {
      final prompt = "Summarize this voice note briefly:\n\n$text";
      log("📤 Sending prompt to Gemini...");

      final response = await _model.generateContent(
        [Content.text(prompt)],
      );

      log("✅ Gemini response received");

      if (response.text == null) {
        log("❌ Response text is NULL");
        log("🔍 Full response: $response");
        return _fallback(text);
      }

      log("📝 Summary length: ${response.text!.length}");
      log("📝 Summary text: ${response.text}");

      return response.text!;
    } catch (e, stack) {
      log("🔥 Gemini ERROR: $e");
      log("📍 STACK TRACE:\n$stack");

      return _fallback(text);
    }
  }

  String _fallback(String text) {
    log("🟠 FALLBACK triggered");
    return text.length > 150
        ? "❌ Gemini failed → ${text.substring(0, 150)}..."
        : text;
  }
}
