  import 'dart:io';
  import 'dart:ui';
  import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';
  import 'dart:typed_data';
  import 'package:http/http.dart' as http;
  import 'package:http_parser/http_parser.dart';
  import 'package:flutter/foundation.dart';
  import 'dart:convert';

  class ApiManager {
  String version = "v3";
  static const String baseUrl = 'http://localhost:8001/ElaachiAgentServices/api'; 
  String t = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJRWE4yRUY0NEo5IiwiaWF0IjoxNzE1MjcxMzc2LCJleHAiOjE3MTUzMTQ1NzZ9.9HThG5DTO84djmbpziVcPY45Ljsvy2DJcY2A9kmifgQ";
  late String? _token;

  ApiManager.instance() {
    _token = t; // Hardcoded token, replace as neededflu
  }

  Map<String, String> get jsonHeader => {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  Map<String, String> get tokenHeader => {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $_token",
  };



  Future<List<String>> fetchInterestsByCategory(String category) async {
    var url = Uri.parse('$baseUrl/$version/domain-values/category/$category');
    var response = await http.get(url, headers: tokenHeader);

    if (response.statusCode == 200) {
      print('Successfully fetched interests for category: $category');
      var jsonResponse = jsonDecode(response.body);
      List<String> interests = List<String>.from(jsonResponse['data'].map((item) => item['name']));
      return interests;
    } else {
      throw Exception('Failed to load interests: ${response.statusCode}');
    }
  }


   Future<List<String>> fetchAffiliations() async {
    var url = Uri.parse('$baseUrl/$version/domain-values/category/AGENT_AFFLIATION');
    var response = await http.get(url, headers: tokenHeader);

    if (response.statusCode == 200) {
      print('Successfully fetched affiliations');
      var jsonResponse = jsonDecode(response.body);
      List<String> affiliations = List<String>.from(jsonResponse['data'].map((item) => item['name']));
      return affiliations;
    } else {
      throw Exception('Failed to load affiliations: ${response.statusCode}');
    }
  }



   Future<List<String>> fetchLanguages() async {
    var url = Uri.parse('$baseUrl/$version/domain-values/category/LANGUAGE');
    var response = await http.get(url, headers: tokenHeader);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<String> languages = List<String>.from(jsonResponse['data'].map((item) => item['name']));
      return languages;
    } else {
      throw Exception('Failed to load languages: ${response.statusCode}');
    }
  }

  Future<bool> uploadFile(Uint8List fileData) async {
    var url = Uri.parse('$baseUrl/$version/files/upload');
    var request = http.MultipartRequest('POST', url);

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      fileData,
      filename: 'upload.jpg',
      contentType: MediaType('image', 'jpeg'), // Change as per your file type
    ));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Upload success: ${response.body}");
        return true;
      } else {
        print("Failed to upload file: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error uploading file: $e");
      return false;
    }
  }
}