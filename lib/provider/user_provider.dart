import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  final String _baseUrl = "https://gtd-gatewayservice.azurewebsites.net/api/v1";
 


  /// Function to fetch Shipment Types
  Future<Map<String, dynamic>> fetchUserProfile(
      {required String token}) async {
    final String endpoint = "$_baseUrl/user/account/profile";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }; 

    try {
      // Send the GET request
      final response = await http.get(Uri.parse(endpoint), headers: headers);

      // Check if response is successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        if (body["succeeded"] == true && body["resultData"] != null) {
         print("Profile Response:${body["resultData"]}");
          return {
            "success": true,
            "data": body["resultData"],
          };
        } else {
          return {
            "success": false,
            "message": body["message"] ?? "Unknown error occurred",
            "data": null,
          };
        }
      } else {
          final errorResponse = jsonDecode(response.body);
          return {
            "success": false,
            "message": errorResponse["message"] ?? "An error occurred",
            "data": null,
          };
        
      }
    } catch (e) {
      // Handle network or unexpected exceptions
      print("Exception: $e");
      return {
        "success": false,
        "message": "An exception occurred: $e",
        "data": null,
      };
    }
  }

}
