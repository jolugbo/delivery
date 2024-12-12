import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  final String _baseUrl = "https://gtd-gatewayservice.azurewebsites.net/api/v1";
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  /// Function to log in
  Future<Map<String, dynamic>> login({
    required String usernameOrPhoneNumber,
    required String password,
  }) async {
    final String endpoint = "$_baseUrl/user/account/login";

    // Construct the request body
    final Map<String, dynamic> body = {
      "usernameOrPhoneNumber": usernameOrPhoneNumber,
      "password": password,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: _headers,
        body: body,
      );

      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": "Login successful",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "message": "Login failed",
          "data": jsonDecode(response.body),
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "An error occurred: $e",
        "data": null,
      };
    }
  }

  Future<Map<String, dynamic>> signup({
    required String firstName,
    required String lastName,
    required String category,
    //required String accountType,
    required String phoneNumber,
    required String email,
    required String password,
    required String confirmPassword,
    required String dateOfBirth,
    required String gender,
    required String username,
  }) async {
    final String endpoint = "$_baseUrl/user/Account/signup";
    print(username);
    log(dateOfBirth);

    // Construct the request body
    final Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "accountType": "Customer",
      "category": category,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "username": username,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body), // Convert body to JSON string
      );

      log(response.body);
      log(response.statusCode.toString());

      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          "success": true,
          "message": "Account created successfully",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "message": "Failed to create account",
          "data": jsonDecode(response.body),
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "An error occurred: $e",
        "data": null,
      };
    }
  }

  /// Function to request a confirmation token
  Future<Map<String, dynamic>> requestConfirmationToken({
    required String emailOrPhone,
    required String confirmationTokenType, // Values: "SMS" or "EMAIL"
    required String userId,
  }) async {
    final String endpoint = "$_baseUrl/user/Account/confirmation-token";

    // Construct the request body
    final Map<String, dynamic> body = {
      "emailOrPhone": emailOrPhone,
      "confirmationTokenType": confirmationTokenType,
      "userId": userId,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: _headers,
        body: jsonEncode(body),
      );
      log(response.body);
      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          "success": true,
          "message": "Confirmation token sent successfully",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "message": "Failed to send confirmation token",
          "data": jsonDecode(response.body),
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "An error occurred: $e",
        "data": null,
      };
    }
  }

  /// Function to verify an account
  Future<Map<String, dynamic>> verifyAccount({
    required String token,
    required String userId,
    required String channel, // Values: "SMS" or "EMAIL"
  }) async {
    final String endpoint = "$_baseUrl/user/Account/verify-account";
    log(token);
    // Construct the request body
    final Map<String, dynamic> body = {
      "token": token,
      "userid": userId,
      "channel": channel,
    };

    log(body.toString());
    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: _headers,
        body: jsonEncode(body),
      );
      log(response.toString());
      log(response.body.toString());
      log(response.statusCode.toString());
      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          "success": true,
          "message": "Account verified successfully",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "message": "Account verification failed",
          "data": jsonDecode(response.body),
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "An error occurred: $e",
        "data": null,
      };
    }
  }

  /// Function to change password
  Future<Map<String, dynamic>> changePassword({
    required String emailOrPhone,
    required String newPassword,
    required String oldPassword,
    required String confirmPassword,
    required String accountType,
  }) async {
    final String endpoint = "$_baseUrl/user/account/change-password";

    // Construct the request body
    final Map<String, dynamic> body = {
      "emailOrPhone": emailOrPhone,
      "newPassword": newPassword,
      "oldPassword": oldPassword,
      "confirmPassword": confirmPassword,
      "accountType": accountType,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: _headers,
        body: jsonEncode(body),
      );

      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": "Password changed successfully",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "message": "Failed to change password",
          "data": jsonDecode(response.body),
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "An error occurred: $e",
        "data": null,
      };
    }
  }
}
