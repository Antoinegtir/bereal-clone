// ignore_for_file: avoid_print

import 'package:flutter/src/widgets/basic.dart';
import 'package:rebeal/model/user.dart';

class PostModel {
  String? key;
  String? imageFrontPath;
  String? imageBackPath;
  late String createdAt;
  UserModel? user;
  List<String?>? comment;

  PostModel({
    this.key,
    required this.createdAt,
    this.imageFrontPath,
    this.imageBackPath,
    this.user,
  });

  toJson() {
    return {
      "createdAt": createdAt,
      "imageBackPath": imageBackPath,
      "imageFrontPath": imageFrontPath,
      "user": user == null ? null : user!.toJson(),
    };
  }

  PostModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    imageFrontPath = map['imageFrontPath'];
    createdAt = map['createdAt'];
    imageFrontPath = map['imageFrontPath'];
    user = UserModel.fromJson(map['user']);
  }

  map(Stack Function(dynamic model) param0) {}
}
