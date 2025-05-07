import 'package:chapasdk/chapasdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChapaService {
  generateTxRef(String userId) {
    String txRef =
        'nova-vitaboard-$userId-${DateTime.now().millisecondsSinceEpoch}';
    return txRef;
  }

  storeTxRef(String txRef) async {
    HiveService hiveService = HiveService();
    await hiveService.initHive(boxName: 'payment-transaction');
    await hiveService.upsertData('subscription-txRef', txRef);
  }

  // makePayment() async {
  //   try {
  //     var headers = {
  //       'Authorization': 'Bearer CHASECK_TEST-P5GMNHJn3R8bRiefB1Ckr4SssiNCM0YU',
  //       'Content-Type': 'application/json',
  //     };
  //     var request = http.Request(
  //       'POST',
  //       Uri.parse('https://api.chapa.co/v1/transaction/initialize'),
  //       // headers: headers,
  //       // body: body,
  //     );
  //     request.body = json.encode({
  //       // var body = json.encode({
  //       "amount": "1000.00",
  //       "currency": "ETB",
  //       "email": "aseffa_dejene@gmail.com",
  //       "first_name": "Bekele",
  //       "last_name": "Doe",
  //       "phone_number": "0912345678",
  //       "tx_ref": "nova-vitaboard-00000000000003",
  //       "callback_url":
  //           "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
  //       "return_url": "https://www.google.com/",
  //       "customization[title]": "Payment for vitaboard",
  //       "customization[description]": "Im accessing paid features,...",
  //       "meta[hide_receipt]": "true",
  //     });
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //     if (response.statusCode == 200) {
  //       print(await response.stream.bytesToString());
  //     } else {
  //       print(response.reasonPhrase);
  //       print(response.statusCode);
  //       print(await response.stream.bytesToString());
  //     }
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  makePayment(BuildContext context) async {
    AuthService authService = AuthService();
    final user = await authService.findSession();
    final String userId = user['id'].toString();
    String txRef = generateTxRef(userId);

    String name = user['name'];

    List<String> parts = name.trim().split(' ');

    String firstName = '';
    String lastName = '';
    String phoneNumber = user['phoneNumber'];

    if (parts.length > 1) {
      firstName = parts[0];
      lastName = parts.sublist(1).join(' '); // In case of more than 2 names
    } else if (parts.length == 1) {
      firstName = parts[0];
      lastName = '';
    }
    try {
      Chapa chapa = Chapa.paymentParameters(
        context: context,
        publicKey: 'CHAPUBK_TEST-tkMFFxPvqa4fCBquDpttftKqSYCSr9yV',
        currency: 'ETB',
        amount: '1000',
        email: 'fetanchapa.co',
        phone: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        txRef: txRef,
        title: 'Subscription Payment',
        desc: 'Payment for vita-board',
        nativeCheckout: true,
        namedRouteFallBack: '/',
        showPaymentMethodsOnGridView: true,
        availablePaymentMethods: ['mpesa', 'cbebirr', 'telebirr', 'ebirr'],
        onPaymentFinished: (message, reference, amount) {
          verifyPayment(context);
        },
      );

      storeTxRef(txRef);

      chapa.initiatePayment();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> verifyPayment(BuildContext context) async {
    HiveService hiveService = HiveService();
    await hiveService.initHive(boxName: 'payment-transaction');
    String txRef = await hiveService.getData('subscription-txRef');

    var headers = {
      'Authorization': 'Bearer CHASECK_TEST-P5GMNHJn3R8bRiefB1Ckr4SssiNCM0YU',
    };
    var request = http.Request(
      'GET',
      Uri.parse('https://api.chapa.co/v1/transaction/verify/$txRef'),
    );
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseStream = await response.stream.bytesToString();
      final responseBody = jsonDecode(responseStream);
      if (responseBody['status'] == 'success') {
        NotificationService().showNotification(
          -3,
          'Subscription Payment',
          'Subscription payment successful!',
          // payload: 'subscription-success||${txRef}',
        );

        await UserRepository().addSubscription(null, '+251911451079');
        Navigator.pushReplacementNamed(context, '/');
      } else {
        NotificationService().showNotification(
          -3,
          'Payment failed',
          'Subscription payment failed!',
          // payload: 'subscription-success||${txRef}',
        );
      }
      return true;
      // print(await response.stream.bytesToString());
    } else {
      NotificationService().showNotification(
        -3,
        'Payment failed',
        'Subscription payment failed!',
        // payload: 'subscription-success||${txRef}',
      );

      print(response.reasonPhrase);
      return false;
      // print(await response.stream.bytesToString());
      // print(response.statusCode);
    }
  }
}
