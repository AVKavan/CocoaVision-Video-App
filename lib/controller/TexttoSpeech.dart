import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class TextToSpeechAPI {
  static const _apiURL = 'texttospeech.googleapis.com';

  Future<String> synthesizeText(String text, String name, String languageCode) async {
    try {
      final uri = Uri.https(_apiURL, '/v1beta1/text:synthesize');
      final Map json = {
        'input': {
          'text': text
        },
        'voice': {
          'name': name,
          'languageCode': languageCode
        },
        'audioConfig': {
          'audioEncoding': 'MP3'
        }
      };

      final jsonResponse = await _postJson(uri, json);
      if (jsonResponse == null) return "";
      final String audioContent = await jsonResponse['audioContent'];
      return audioContent;
    } on Exception catch(e) {
      return "";
    }
  }

  Future<Map<String, dynamic>> _postJson(Uri url, Map json) async {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': 'AIzaSyDvnOPlcuo-EewI1YU-wSPuY4-bQAir5CE',
      },
      body: jsonEncode(json),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}