import 'package:flutter/material.dart';
import 'package:news/model/network_datasource.dart';

import '../model/actu.dart';

class ActuRepository {
  final NetworkDataSource _actuDataSource = NetworkDataSource();

  ActuRepository();

  Future<List<Actu>> getActus() async {
    return _actuDataSource.getActus('/events');
  }

  Future<String> getPageHtml() async {
    return _actuDataSource.getPageHtml('/html');
  }

  Future<String> registerUser(String name, String email, String phone, String picture) async {
    return _actuDataSource.registerUser(name, email, phone, picture);
  }
}