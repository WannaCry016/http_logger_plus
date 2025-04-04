import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpLoggerClient extends http.BaseClient {
  final http.Client _inner;
  final int maxBodyLength;

  HttpLoggerClient({http.Client? inner, this.maxBodyLength = 1000})
      : _inner = inner ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final stopwatch = Stopwatch()..start();

    // Log Request
    _logRequest(request);

    if (request is http.Request && request.body.isNotEmpty) {
      _logBody('Request Body', request.body);
    }

    final streamedResponse = await _inner.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    stopwatch.stop();

    // Log Response
    _logResponse(response, stopwatch.elapsedMilliseconds);

    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
      request: response.request,
      reasonPhrase: response.reasonPhrase,
    );
  }

  void _logRequest(http.BaseRequest request) {
    print('🟦 [${request.method}] ${request.url}');
    if (request.headers.isNotEmpty) {
      print('Headers:');
      request.headers.forEach((k, v) => print('  $k: $v'));
    }
    print(_generateCurl(request));
  }

  void _logResponse(http.Response response, int durationMs) {
    final status = response.statusCode;
    final color = status >= 200 && status < 300
        ? '\x1B[32m' // green
        : status >= 400
            ? '\x1B[31m' // red
            : '\x1B[33m'; // yellow

    print(
        '⬇️ Response ${color}[${response.statusCode} ${response.reasonPhrase}]\x1B[0m (${durationMs}ms)');
    if (response.headers.isNotEmpty) {
      print('Content-Type: ${response.headers['content-type']}');
    }
    _logBody('Response Body', response.body);
  }

  void _logBody(String label, String body) {
    if (body.isEmpty) return;

    final display = body.length > maxBodyLength
        ? body.substring(0, maxBodyLength) + '... (truncated)'
        : body;

    try {
      final decoded = json.decode(display);
      final encoder = JsonEncoder.withIndent('  ');
      print('$label:\n${encoder.convert(decoded)}');
    } catch (_) {
      print('$label:\n$display');
    }
  }

  String _generateCurl(http.BaseRequest request) {
    final sb = StringBuffer();
    sb.write('💡 curl -X ${request.method} "${request.url}"');

    request.headers.forEach((key, value) {
      sb.write(' -H "$key: $value"');
    });

    if (request is http.Request && request.body.isNotEmpty) {
      sb.write(" -d '${request.body}'");
    }

    return sb.toString();
  }
}
