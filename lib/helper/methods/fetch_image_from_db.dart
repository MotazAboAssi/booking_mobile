import 'package:booking/helper/constant/api.dart';
import 'package:flutter/material.dart';

ImageProvider fetchImageFromDB(String path) {
  return NetworkImage("$baseURL/storage/$path");
}
