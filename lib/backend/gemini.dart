import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nmax/api_keys.dart';

Future<String> sendPrompt(String prompt) async {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: ApiKeys.geminiApiKey,
  );

  final content = [Content.text(prompt)];
  final response = await model.generateContent(content);

  return (response.text.toString());
}
