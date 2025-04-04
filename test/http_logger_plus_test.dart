import 'package:test/test.dart';
import 'package:http_logger_plus/http_logger_plus.dart';

void main() {
  final client = HttpLoggerClient();

  test('GET request returns 200', () async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );
    expect(response.statusCode, 200);
    expect(response.body.contains('userId'), isTrue);
  });

  test('POST request returns 201', () async {
    final response = await client.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: '{"title": "test", "body": "content", "userId": 1}',
    );
    expect(response.statusCode, 201);
    expect(response.body.contains('title'), isTrue);
  });
}
