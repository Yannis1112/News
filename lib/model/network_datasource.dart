import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/model/actu.dart';

class NetworkDataSource {

  static final NetworkDataSource _instance = NetworkDataSource._internal();
  factory NetworkDataSource() => _instance;
  NetworkDataSource._internal();

  Future<List<Actu>> getActus(String endpoint, {Map<String, String>? params}) async {
    final uri = Uri.parse("https://test-pgt-dev.apnl.ws$endpoint").replace(queryParameters: params);
    final response = await http.get(uri, headers: {
      'X-AP-Key': 'uD4Muli8nO6nzkSlsNM3d1Pm',
      'X-AP-DeviceUID': 'trial',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> parsedList = jsonDecode(response.body) as List<dynamic>;
      return parsedList.map((json) => Actu.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Erreur lors de l'appel GET : ${response.statusCode}");
    }
  }

  Future<String> getPageHtml(String endpoint, {Map<String, String>? params}) async {
    final uri = Uri.parse("https://test-pgt-dev.apnl.ws$endpoint").replace(queryParameters: params);
    final response = await http.get(uri, headers: {
      'X-AP-Key': 'uD4Muli8nO6nzkSlsNM3d1Pm',
      'X-AP-DeviceUID': 'trial',
      'Accept': 'text/html',
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Erreur lors de l'appel GET : ${response.statusCode}");
    }
  }

  Future<String> registerUser(String name, String email, String phone, String picture) async {
    final uri = Uri.parse("https://test-pgt-dev.apnl.ws/authentication/register");
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'X-AP-Key': 'uD4Muli8nO6nzkSlsNM3d1Pm',
        'X-AP-DeviceUID': 'Documentation',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'picture': picture,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Erreur lors de l'inscription : ${response.statusCode}");
    }
  }
}