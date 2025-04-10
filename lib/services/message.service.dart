// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> sendMessage({
//   required String identifierId,
//   required String senderName,
//   required String recipient,
//   required String message,
//   String? callbackUrl,
// }) async {
//   final uri = Uri.parse('https://api.afromessage.com/api/send').replace(
//     queryParameters: {
//       'from': identifierId,
//       'sender': senderName,
//       'to': recipient,
//       'message': message,
//       'callback': callbackUrl,
//     },
//   );

//   try {
//     final response = await http.get(uri);
//     if (response.statusCode == 200) {
//       print('Message sent successfully: ${response.body}');
//     } else {
//       print('Failed to send message: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error sending message: $e');
//   }
// }

import 'package:http/http.dart' as http;

Future<void> sendMessage({
  required String token,
  required String identifierId,
  required String senderName,
  required String recipient,
  required String message,
  String? callbackUrl,
}) async {
  final uri = Uri.parse('https://api.afromessage.com/api/send').replace(
    queryParameters: {
      'from': identifierId,
      'sender': senderName,
      'to': recipient,
      'message': message,
      'callback': callbackUrl,
    },
  );

  try {
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Message sent successfully: ${response.body}');
    } else {
      print(
        'Failed to send message: ${response.statusCode} - ${response.body}',
      );
    }
  } catch (e) {
    print('Error sending message: $e');
  }
}
