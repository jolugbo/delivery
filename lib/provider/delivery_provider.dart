import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeliveryProvider with ChangeNotifier {
  final String _baseUrl = "https://gtd-gatewayservice.azurewebsites.net/api/v1";

  /// Function to fetch Shipment Category
  Future<Map<String, dynamic>> fetchShipmentCat({required String token}) async {
    final String endpoint =
        "$_baseUrl/shipment/category?pageSize=15&page=1&search=";
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
          //print("Category Response: ${ body["resultData"]["data"]}");
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

  /// Function to fetch Shipment Types
  Future<Map<String, dynamic>> fetchShipmentType(
      {required String token}) async {
    final String endpoint =
        "$_baseUrl/shipment/shipmenttype?pageSize=15&page=1&search=";
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
        final errorResponse = jsonDecode(response.body);
        return {
          "success": false,
          "message": errorResponse["message"] ?? "An error occurred",
          "data": null,
        };
      }
    } catch (e) {
      // Handle network or unexpected exceptions
      print("Exceptions: $e");
      return {
        "success": false,
        "message": "An exception occurred: $e",
        "data": null,
      };
    }
  }

  /// Function to fetch Item Category
  Future<Map<String, dynamic>> fetchItemCategory(
      {required String token}) async {
    final String endpoint =
        "$_baseUrl/shipment/itemcategory?pageSize=15&page=1&search=";
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
        final errorResponse = jsonDecode(response.body);
        return {
          "success": false,
          "message": errorResponse["message"] ?? "An error occurred",
          "data": null,
        };
      }
    } catch (e) {
      // Handle network or unexpected exceptions
      print("Exceptions: $e");
      return {
        "success": false,
        "message": "An exception occurred: $e",
        "data": null,
      };
    }
  }

  /// Function to fetch Item SubCategory
  Future<Map<String, dynamic>> fetchItemSubCategory(
      {required String token, required String code}) async {
    final String endpoint = "$_baseUrl/shipment/itemcategory/3304";
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
          return {
            "success": true,
            "data": body["resultData"]["subCategories"],
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
      return {
        "success": false,
        "message": "An exception occurred: $e",
        "data": null,
      };
    }
  }

  /// Function to get Courier
  Future<Map<String, dynamic>> getCourier({
    required dynamic couriersRequest,
    required String token,
  }) async {
    final String endpoint = "$_baseUrl/shipment/order/couriers";

    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
      print("got here...........");
    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(couriersRequest),
      );
      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Couriers: ${jsonDecode(response.body)}");
        return {
          "success": true,
          "data": jsonDecode(response.body),
        };
      } else {
        print("Error: ${jsonDecode(response.body)}");
        return {
          "success": false,
          "message": "Failed to get couriers",
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

 /// Function to get Estimates
  Future<Map<String, dynamic>> getEstimates({
    required dynamic estimateRequest,
    required String token,
  }) async {

    final String endpoint = "$_baseUrl/shipment/order/estimate";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
    try {
      print("got here............$estimateRequest");
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(estimateRequest),
      );
      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
      print("got here...........${jsonDecode(response.body)["resultData"]}");
        return {
          "success": true,
          "data": jsonDecode(response.body)["resultData"],
        };
      } else {
        print("Error: ${jsonDecode(response.body)["message"]}");
        return {
          "success": false,
          "message":  jsonDecode(response.body)["message"],
          "data": "Failed to get estimates",
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

 /// Function to create Order
  Future<Map<String, dynamic>> createOrder({
    required dynamic orderRequest,
    required String token,
  }) async {

    final String endpoint = "$_baseUrl/shipment/order/create";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(orderRequest),
      );
      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
      print("got here...........${jsonDecode(response.body)}");
        return {
          "success": true,
          "data": jsonDecode(response.body)["resultData"],
        };
      } else {
        print("Error: ${jsonDecode(response.body)}");
        return {
          "success": false,
          "message": jsonDecode(response.body)["message"],
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

 /// Function to create payment
  Future<Map<String, dynamic>> createpayment({
    required dynamic paymentRequest,
    required String token,
  }) async {

    final String endpoint = "$_baseUrl/shipment/payment/create";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(paymentRequest),
      );
      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
      //print("got here...........${jsonDecode(response.body)}");
        return {
          "success": true,
          "data": jsonDecode(response.body)["resultData"],
        };
      } else {
        print("Error: ${jsonDecode(response.body)}");
        return {
          "success": false,
          "message": "Failed to get estimates",
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

 /// Function to confirm payment
  Future<Map<String, dynamic>> confirmpayment({
    required dynamic paymentRequest,
    required String token,
  }) async {

    final String endpoint = "$_baseUrl/shipment/payment/confirm";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(paymentRequest),
      );
      // Handle response
      if (response.statusCode == 201 || response.statusCode == 200) {
      //print("got here...........${jsonDecode(response.body)}");
        return {
          "success": true,
          "data": jsonDecode(response.body)["resultData"],
        };
      } else {
        print("Error: ${jsonDecode(response.body)}");
        return {
          "success": false,
          "message": "Failed to confirm payment",
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

  /// Function to fetch Receipt
  Future<Map<String, dynamic>> fetchReceipt({required String token,required String orderNo}) async {
    final String endpoint =
        "$_baseUrl/shipment/order/$orderNo/receipt";
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
          //print("Receipt Response: ${body}");
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
