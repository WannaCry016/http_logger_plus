import 'package:http_logger_plus/http_logger_plus.dart';

void main() async {
  final client = HttpLoggerClient();

  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
  );

  print('\nStatus Code: ${response.statusCode}');
}
