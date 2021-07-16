import 'dart:io';
import 'package:pf_dart_http/src/pf_dart_http.dart';


void printResponse(PFHttpResponse response){
  print('\n\n');
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

Future<void> main() async {
  var baseURL = "https://flask-hmtmcse.herokuapp.com/";

  var data = {
    "description": "postJsonRequest",
    "name": "postJsonRequest",
    "target": "postJsonRequest",
    "targetType": "postJsonRequest",
    "title": "postJsonRequest",
    "type": "TextOnly"
  };

  var jsonCreate = {
    'data': {
      "description": "postJsonRequest",
      "name": "postJsonRequest",
      "target": "postJsonRequest",
      "targetType": "postJsonRequest",
      "title": "postJsonRequest",
      "type": "TextOnly"
    }
  };

  var jsonUpdate = {
    'data': {
      "id": 1,
      "description": "Update Description",
      "name": "Update name",
      "target": "Update target",
      "targetType": "Update targetType",
      "title": "Update title",
      "type": "TextOnly"
    }
  };

  var response;

  // POST upload file Request
  var file = File("C:\\Users\\hmtmc\\Desktop\\gm\\consumer\\8.order-list.jpeg");
  var uploadFileMap = {
    "name": file
  };
  response = await PFDartHTTP.instance().uploadRequest(baseURL + "api/v1/card/upload-file", uploadFileMap);
  printResponse(response);


  // FORM Data POST Request
  response = await PFDartHTTP.instance().POSTRequest(baseURL + "api/v1/card/form-data", data: data);
  printResponse(response);

  // JSON POST Request
  response = await PFDartHTTP.instance().jsonPOSTRequest(baseURL + "api/v1/card/create", data: jsonCreate);
  printResponse(response);

  // Simple GET Request
  response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/list");
  printResponse(response);

  // PUT JSON Request
  response = await PFDartHTTP.instance().jsonPUTRequest(baseURL + "api/v1/card/update", data: jsonUpdate);
  printResponse(response);

  // GET Request with parameter 1
  response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/details/1");
  printResponse(response);


  // GET Request with query parameter data
  var params = {
    'per-page': '1',
    'page': '1',
  };
  response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/list", params: params);
  printResponse(response);

  // GET Request with query param
  response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/list?sort-order=asc");
  printResponse(response);

  // GET Request with query param & with data
  params = {
    'per-page': '5',
    'page': '1',
  };
  response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/list?sort-order=asc", params: params);
  printResponse(response);

  // DELETE GET Request with parameter 1
  response = await PFDartHTTP.instance().DELERERequest(baseURL + "api/v1/card/delete/1");
  printResponse(response);

  // GET Request with query param
  response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/list?sort-order=asc");
  printResponse(response);

  // GET Request with parameter 1
  response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/restore/1");
  printResponse(response);

  // GET Request with query param
  response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/list?sort-order=asc");
  printResponse(response);


}