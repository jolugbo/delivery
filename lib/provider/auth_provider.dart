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
    print(body);
    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": "Login successful",
          "data": jsonDecode(response.body),
        };
      } else {
        print(jsonDecode(response.body));
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
      print("Failed here......................... $e");
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
      print("got here............$e");
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

  /// Function to fetch sec Que
  Future<Map<String, dynamic>> fetchSecQue() async {
    final String endpoint = "$_baseUrl/user/SecurityQuestion?Page=1&PageSize=5";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    print("endpoint: $endpoint");
    try {
      // Send the GET request
      final response = await http.get(Uri.parse(endpoint), headers: headers);

      print("Response Status CodeS: ${response.statusCode}");

      // Check if response is successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        print("Response Body: ${body["message"]}");
        if (body["succeeded"] == true && body["resultData"] != null) {
          return {
            "success": true,
            "data": body["resultData"]["data"],
          };
        } else {
          return {
            "success": false,
            "message": body["message"] ?? "Unknown error occurred",
            "data": null,
          };
        }
      } else {
        // Handle error responses
        try {
          final errorResponse = jsonDecode(response.body);
          return {
            "success": false,
            "message": errorResponse["message"] ?? "An error occurred",
            "data": null,
          };
        } catch (_) {
          return {
            "success": false,
            "message": "Failed to parse error response.",
            "data": null,
          };
        }
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

  /// Function to verify an account
  Future<Map<String, dynamic>> setSecQue({
    required Map<String, dynamic> body, // Values: "SMS" or "EMAIL"
  }) async {
    final String endpoint = "$_baseUrl/user/SecurityQuestion/answer?";

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
          "message": "Security Questions Completed",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "message": "Security Questions failed",
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

  /// Function to request a password reset token
  Future<Map<String, dynamic>> requestPasswordResetToken({
    required String emailOrPhone,
    required String channel, // Values: "SMS" or "EMAIL"
    required String accountType,
  }) async {
    final String endpoint = "$_baseUrl/user/Account/reset-token";

    // Construct the request body
    final Map<String, dynamic> body = {
      "emailOrPhone": emailOrPhone,
      "channel": channel,
      "accountType": accountType,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: _headers,
        body: jsonEncode(body),
      );
      log(response.body);
      log(response.body);
      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          "success": true,
          "message": "Password reset token sent successfully",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "message": "Failed to send Password reset token",
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

  /// Function to change password
  Future<Map<String, dynamic>> resetPassword({
    required String emailOrPhone,
    required String newPassword,
    required String confirmPassword,
    required String channel,
    required String token,
    required String accountType,
  }) async {
    final String endpoint = "$_baseUrl/user/account/reset-password";

    // Construct the request body
    final Map<String, dynamic> body = {
      "emailOrPhone": emailOrPhone,
      "NewPassword": newPassword,
      "ConfirmPassword": confirmPassword,
      "channel": channel,
      "token": token,
      "accountType": accountType,
    };

    print(body);
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
          "message": "Password reset successfully",
          "data": jsonDecode(response.body),
        };
      } else {
        print(jsonDecode(response.body));
        return {
          "success": false,
          "message": jsonDecode(response.body)['Message'],
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
