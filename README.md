# Problem Fighter Dart HTTP Request Library

## Simple Print Method
```dart
void printResponse(PFHttpResponse response){
  print('\n\n');
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
```

## POST Request
```dart
var baseURL = "https://flask-hmtmcse.herokuapp.com/";
var data = {
  "description": "postJsonRequest",
  "name": "postJsonRequest",
  "target": "postJsonRequest",
  "targetType": "postJsonRequest",
  "title": "postJsonRequest",
  "type": "TextOnly"
};

var response = await PFDartHTTP.instance().POSTRequest(baseURL + "api/v1/card/form-data", data: data);
printResponse(response);
```

## JSON POST Request
```dart
var baseURL = "https://flask-hmtmcse.herokuapp.com/";
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

var response = await PFDartHTTP.instance().jsonPOSTRequest(baseURL + "api/v1/card/create", data: jsonCreate);
printResponse(response);
```

## Simple Get Request
```dart
var baseURL = "https://flask-hmtmcse.herokuapp.com/";
var response = await PFDartHTTP.instance().GETRequest(baseURL + "api/v1/card/list");
printResponse(response);
```

## POST upload file Request
```dart
var baseURL = "https://flask-hmtmcse.herokuapp.com/";
var file = File("C:\\Users\\hmtmc\\Desktop\\gm\\consumer\\8.order-list.jpeg");
var uploadFileMap = {
  "name": file
};
var response = await PFDartHTTP.instance().uploadRequest(baseURL + "api/v1/card/upload-file", uploadFileMap);
printResponse(response);
```