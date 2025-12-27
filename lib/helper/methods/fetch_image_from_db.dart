import 'package:booking/helper/constant/api.dart';
import 'package:booking/helper/constant/images.dart';
import 'package:flutter/material.dart';

ImageProvider fetchImageFromDB(String path) {
  try {
    return NetworkImage("$baseURL/storage/$path");
  } catch (e) {
    return AssetImage(anonymousManAvatar);
  }
}
