import '../services/ai_service.dart';

class AiController {

  AiService aiService = AiService();


  Future<String> generateSummary(String text) async{
    return await aiService.summarize(text);
  }
  
}