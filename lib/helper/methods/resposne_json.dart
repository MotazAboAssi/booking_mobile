Map<String, dynamic> resposneJson(bool isSuccess, dynamic payload) {
  return isSuccess
      ? {"success": isSuccess, "data": payload.toString()}
      : {"success": isSuccess, "error": payload.toString()};
}
