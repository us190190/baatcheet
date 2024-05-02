import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class AppConfigModel extends ChangeNotifier {
  late String apiIP;
  late String apiPORT;
  late String chatHubIP;
  late String chatHubPORT;

  void setConfig(String apiIP, String apiPORT, String chatHubIP, String chatHubPORT) {
    this.apiIP = apiIP;
    this.apiPORT = apiPORT;
    this.chatHubIP = chatHubIP;
    this.chatHubPORT = chatHubPORT;
    notifyListeners();
  }
}


Future<bool> initializeAppConfig(AppConfigModel appConfig) async {
  // Perform any initialization tasks here, such as loading app configuration from files or APIs
  // You can use packages like shared_preferences, http, or path_provider for this purpose

  // Example: Loading app configuration from a file
  return await loadAppConfigFromFile(appConfig);

  // Example: Loading app configuration from an API
  // await loadAppConfigFromApi();
}

Future<bool> loadAppConfigFromFile(AppConfigModel appConfig) async {
  try {
    // // Read configuration data from a file (for example, 'config.json')
    // String configData = await rootBundle.loadString('assets/config.json');
    //
    // // Parse the JSON data
    // Map<String, dynamic> configMap = json.decode(configData);
    //
    // // Extract configuration values
    // String apiIP = configMap['API_IP'];
    // String apiPORT = configMap['API_PORT'];
    // String chatHubIP = configMap['CHAT_HUB_IP'];
    // String chatHubPORT = configMap['CHAT_HUB_PORT'];
    String apiIP = "192.168.1.94";
    String apiPORT = "443";
    String chatHubIP = "192.168.1.94";
    String chatHubPORT = "443";
    appConfig.setConfig(apiIP, apiPORT, chatHubIP, chatHubPORT);

    print('API config initialized: $apiIP, $apiPORT, $chatHubIP, $chatHubPORT');

  } catch (e) {
    print('Error loading app configuration: $e');
    // Handle errors, such as the config file not found or invalid JSON format
    return false;
  }
  return true;

}

Future<void> loadAppConfigFromApi() async {
  try {
    // Make a GET request to fetch configuration data from the API
    String apiUrl = 'https://example.com/app-config';
    http.Response response = await http.get(Uri.parse(apiUrl));

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response body
      Map<String, dynamic> configMap = json.decode(response.body);

      // Extract configuration values
      String apiKey = configMap['api_key'];
      String apiUrl = configMap['api_url'];

      // Use the configuration values as needed
      print('API Key: $apiKey');
      print('API URL: $apiUrl');

      // You can assign these values to global variables or use them directly in your app
      // For example:
      // AppConfig.apiKey = apiKey;
      // AppConfig.apiUrl = apiUrl;
    } else {
      print('Failed to load app configuration: ${response.statusCode}');
      // Handle the case when the request is unsuccessful
    }
  } catch (e) {
    print('Error loading app configuration: $e');
    // Handle errors, such as network errors or invalid JSON format
  }
}
