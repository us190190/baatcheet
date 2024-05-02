import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/initialize_app_config.dart';
import '../utils/common_view_components.dart';
import 'dart:io';

Future<List<dynamic>> fetchUsers(BuildContext context) async {
  try {
    // TODO fetch config from cloud front or equivalent
    AppConfigModel appConfig =
        Provider.of<AppConfigModel>(context, listen: false);
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) =>
            true); // TODO handle certificate validation for prod
    HttpClientRequest request = await client.getUrl(Uri.parse(
        "https://${appConfig.apiIP}:${appConfig.apiPORT}/v1/user/all"));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      return jsonDecode(await response.transform(utf8.decoder).join());
    } else {
      showAlertDialog(context, 'Response exception', 'Failed to load users');
    }
  } catch (e) {
    showAlertDialog(context, 'Response exception', 'Error fetching users: $e');
  }
  return [];
}

Future<List<dynamic>> fetchGroups(BuildContext context) async {
  try {
    // TODO fetch config from cloud front or equivalent
    AppConfigModel appConfig =
        Provider.of<AppConfigModel>(context, listen: false);
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) =>
            true); // TODO handle certificate validation for prod
    HttpClientRequest request = await client.getUrl(Uri.parse(
        "https://${appConfig.apiIP}:${appConfig.apiPORT}/v1/group/all"));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      return jsonDecode(await response.transform(utf8.decoder).join());
    } else {
      showAlertDialog(context, 'Response exception', 'Failed to load groups');
    }
  } catch (e) {
    showAlertDialog(context, 'Response exception', 'Error fetching groups: $e');
  }
  return [];
}

Future<Map<String, dynamic>> authenticateUser(
    BuildContext context, String username, String password) async {
  // TODO fetch config from cloud front or equivalent
  // Access AppConfigModel from Provider
  AppConfigModel appConfig =
      Provider.of<AppConfigModel>(context, listen: false);

  try {
    // Create a custom HttpClient with certificate validation disabled
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) =>
            true); // TODO handle certificate validation for prod
    HttpClientRequest request = await client.postUrl(Uri.parse(
        "https://${appConfig.apiIP}:${appConfig.apiPORT}/v1/user/authenticate"));
    request.headers.set('Content-Type', 'application/json');
    // if(isTokenHeader){
    //   request.headers.set('Authorization', 'Bearer $token');
    // }
    request.add(
        utf8.encode(jsonEncode({"username": username, "password": password})));
    HttpClientResponse result = await request.close();

    if (result.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await result.transform(utf8.decoder).join());
      // showAlertDialog(context, 'Response info', jsonResponse.toString());
      return jsonResponse;
    } else {
      showAlertDialog(context, 'Login Error', result.reasonPhrase);
    }
  } catch (e) {
    showAlertDialog(context, 'Response exception', 'Error authenticating user: $e');
  }

  return {};
}
