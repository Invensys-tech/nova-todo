import 'package:chapasdk/chapasdk.dart';
import 'package:flutter/material.dart';

class ChapaService {
  makePayment({
    required BuildContext context,
    required String publicKey,
    required String currency,
    required String amount,
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String txRef,
    required String title,
    required String desc,
    required String namedRouteFallBack,
  }) {
    Chapa.paymentParameters(
      context: context,
      publicKey: publicKey,
      currency: currency,
      amount: amount,
      email: email,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      txRef: txRef,
      title: title,
      desc: desc,
      namedRouteFallBack: namedRouteFallBack,
    );
  }
}
