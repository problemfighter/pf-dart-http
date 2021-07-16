import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PFHttpResponse {
  int statusCode;
  String body;
  PFHttpResponse({required this.statusCode, required this.body});
}



class PFHTTPRequester {

  static const APPLICATION_JSON = "application/json";
  static const CONTENT_TYPE = "Content-Type";
  static const GET = "GET";
  static const POST = "POST";
  static const PUT = "PUT";
  static const DELETE = "DELETE";


  Map<String, String> _headers = {};

  PFHTTPRequester addHeader(String key, String value) {
    _headers[key] = value;
    return this;
  }

  Map<String, String> getHeaders() {
    return _headers;
  }

  PFHTTPRequester clearHeader() {
    _headers = {};
    return this;
  }

  static PFHTTPRequester instance() {
    return PFHTTPRequester();
  }

  Future<PFHttpResponse> requestTo(String url, String method, {Object? data}) async {
    var uri = Uri.parse(url);

    if ((method == GET || method == DELETE) && data is Map) {
      var queryParams = Map<String, dynamic>.from(data);
      queryParams.addAll(uri.queryParameters);
      uri = uri.replace(queryParameters: queryParams);
    }

    http.Request request = http.Request(method, uri);
    var encoding = Encoding.getByName("utf-8");
    request.encoding = encoding!;

    if ((method == GET || method == DELETE) && data is Map) {
      // Ignore
    } else if (data is String) {
      request.body = data;
    } else if (data is Map) {
      request.bodyFields = Map<String, String>.from(data);
    }

    request.headers.addAll(_headers);

    final response = await request.send();
    return new PFHttpResponse(statusCode: response.statusCode, body: await response.stream.bytesToString());
  }

  Future<PFHttpResponse> GETRequest(String url, {Map<String, String>? params}) async {
    return await requestTo(url, GET, data: params);
  }

  Future<PFHttpResponse> _jsonRequest(String url, String method, {Map<String, dynamic>? data}) async {
    addHeader(CONTENT_TYPE, APPLICATION_JSON);
    String? jsonString;
    if(data is Map){
      jsonString = json.encode(data);
    }
    return await requestTo(url, method, data: jsonString);
  }

  Future<PFHttpResponse> POSTRequest(String url, {Map<String, String>? data}) async {
    return await requestTo(url, POST, data: data);
  }

  Future<PFHttpResponse> jsonPOSTRequest(String url, {Map<String, dynamic>? data}) async {
    return await _jsonRequest(url, POST, data: data);
  }

  Future<PFHttpResponse> PUTRequest(String url, {Map<String, String>? data}) async {
    return await requestTo(url, PUT, data: data);
  }

  Future<PFHttpResponse> jsonPUTRequest(String url, {Map<String, dynamic>? data}) async {
    return await _jsonRequest(url, PUT, data: data);
  }

  Future<PFHttpResponse> DELERERequest(String url, {Map<String, String>? data}) async {
    return await requestTo(url, DELETE, data: data);
  }

  Future<PFHttpResponse> jsonDELETERequest(String url, {Map<String, dynamic>? data}) async {
    return await _jsonRequest(url, DELETE, data: data);
  }


  Future<http.MultipartFile> _getMultipartFileInfo(File file, String fieldName) async {
    return await http.MultipartFile.fromPath(fieldName, file.path);
  }

  Future<PFHttpResponse> uploadRequest(String url, Map<String, File> files, {Map<String, String>? data, method = POST}) async {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest(method, uri);
    if (data is Map) {
      request.fields.addAll(Map<String, String>.from(data!));
    }

    if (files is Map){
      files.forEach((name, file) async {
        if (name is String && file is File && await file.exists()){
          http.MultipartFile multipartFile = await _getMultipartFileInfo(file, name);
          if (multipartFile is http.MultipartFile){
            request.files.add(multipartFile);
          }
        }
      });
    }

    final response = await request.send();
    return new PFHttpResponse(statusCode: response.statusCode, body: await response.stream.bytesToString());
  }

}
