// import 'package:http/http.dart' as http;

// Future<void> sendMessage({
//   required String token,
//   required String identifierId,
//   required String senderName,
//   required String recipient,
//   required String message,
//   String? callbackUrl,
// }) async {
//   final uri = Uri.parse('https://api.afromessage.com/api/send').replace(
//     queryParameters: {
//       'from': '',
//       'sender': senderName,
//       'to': recipient,
//       'message': message,
//       // 'callback': callbackUrl,
//     },
//   );

//   try {
//     final response = await http.get(
//       uri,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer ${token}',
//       },
//     );

//     if (response.statusCode == 200) {
//       print('Message sent successfully: ${response.body}');
//     } else {
//       print(
//         'Failed to send message: ${response.statusCode} - ${response.body}',
//       );
//     }
//   } catch (e) {
//     print('Error sending message: $e');
//   }
// }

import 'package:http/http.dart' as http;

Future<void> sendMessage({
  required String token,
  // required String identifierId,
  // required String senderName,
  required String recipient,
  required String message,
  String? callbackUrl,
}) async {
  // Build a map of query parameters and remove any that are empty or null.
  final Map<String, String> queryParameters = {
    'from': 'e80ad9d8-adf3-463f-80f4-7c4b39f7f164',

    'sender': 'Buna Labs',
    'to': recipient,
    'message': message,
    // if (callbackUrl != null && callbackUrl.isNotEmpty) 'callback': callbackUrl,
  };

  // Construct the URI with the provided query parameters.
  final uri = Uri.parse(
    'https://api.afromessage.com/api/send',
  ).replace(queryParameters: queryParameters);

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