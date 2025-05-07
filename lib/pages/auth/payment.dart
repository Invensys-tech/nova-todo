import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/chapa.service.dart';

class PaymentPage extends StatefulWidget {
  final BuildContext context;
  const PaymentPage({super.key, required this.context});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isPaid = false;
  ChapaService chapaService = ChapaService();

  handleMakePayment() {
    chapaService.makePayment(widget.context);
  }

  verifyPayment() async {
    // bool isPaid = await chapaService.verifyPayment();
    if (isPaid) {
      dynamic session = await AuthService().findSession();
      await UserRepository().addSubscription(null, session['phoneNumber']);
      print('before routing');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreenPage()),
      );
      print('after routing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Payment needed', style: TextStyle(fontSize: 24)),
          ElevatedButton(onPressed: handleMakePayment, child: Text('Pay Now')),
          ElevatedButton(
            onPressed: verifyPayment,
            child: Text('Verify Payment'),
          ),
        ],
      ),
    );
  }
}
