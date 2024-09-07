import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('https://api.adviceslip.com/advice'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('slip') && data['slip'].containsKey('advice')) {
          final quote = data['slip']['advice'];
          print('Fetched quote: $quote');
          return quote;
        } else {
          print('Unexpected data format: $data');
          throw Exception('Unexpected data format');
        }
      } else {
        print('Failed to load quote: ${response.statusCode}');
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching quote');
    }
  }
}