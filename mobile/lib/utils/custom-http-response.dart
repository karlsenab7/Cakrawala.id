import 'dart:ffi';

class CustomHttpResponse<T> {
  int status;
  String message;
  T data;

  CustomHttpResponse(this.status, this.message, this.data);
}