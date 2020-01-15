import 'package:http/http.dart' as http;

class HttpClient {
  Map<String, String> head = {};

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      head['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  void setCookie(String key, String data) {
    head[key] = data;
  }

  Future<http.Response> get(String url, {Map<String, String> headers}) async {
    if (headers != null) {
      headers.addAll(head);
      final response = await http.get(url, headers: headers);
      updateCookie(response);
      return response;
    } else {
      final response = await http.get(url, headers: headers);
      updateCookie(response);
      return response;
    }
  }

  Future<http.Response> post(String url,
      {Map<String, String> headers, dynamic body}) async {
    if (headers != null) {
      if (body != null) {
        headers.addAll(head);
        final response = await http.post(url, headers: headers, body: body);
        updateCookie(response);
        return response;
      } else {
        headers.addAll(head);
        final response = await http.post(url, headers: headers);
        updateCookie(response);
        return response;
      }
    } else {
      if (body != null) {
        final response = await http.post(url, headers: headers, body: body);
        updateCookie(response);
        return response;
      } else {
        final response = await http.post(url, headers: headers);
        updateCookie(response);
        return response;
      }
    }
  }
}
