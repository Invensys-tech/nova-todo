// import 'package:another_telephony/telephony.dart';
// import 'package:flutter_application_1/services/notification.service.dart';

// class SmsService {
//   final Telephony telephonyInstance = Telephony.instance;

//   sendSms(String recipient, String message) {
//     telephonyInstance.sendSms(to: recipient, message: message);
//   }

//   listenSms() {
//     telephonyInstance.listenIncomingSms(
//       onNewMessage: (SmsMessage message) {
//         print(message.body);
//       },
//       listenInBackground: false,
//     );
//   }

//   parseSms(SmsMessage message) {
//     if (message.body != null) {
//       if (!message.address!.contains('CBE')) return;
//       RegExp regExp = RegExp(
//         r'(debited|credited)\s*with\s*ETB\s*(\d+\.\d{2})',
//         caseSensitive: false,
//       );
//       Match? match = regExp.firstMatch(message.body!);

//       if (match != null) {
//         if (message.body!.contains('Debited') ||
//             message.body!.contains('debited')) {
//           print('Debit SMS detected');
//           NotificationService().showNotification(
//             -2,
//             'Income',
//             'Tap to add expense from ${message.address}',
//             payload: 'add-expense||${match.group(2)}',
//           );
//         } else if (message.body!.contains('Credited') ||
//             message.body!.contains('credited')) {
//           print('Credit SMS detected');
//           NotificationService().showNotification(
//             -2,
//             'Income',
//             'Tap to add income from ${message.address}',
//             payload: 'add-income||${match.group(2)}',
//           );
//         } else {
//           print('Unknown SMS type detected');
//         }
//       }
//     }
//   }
// }

// enum SmsType { DEBIT, CREDIT }

// class SmsInstance {
//   final String bank;
//   final SmsType type;
//   final double amount;

//   SmsInstance({required this.bank, required this.type, required this.amount});

//   factory SmsInstance.fromJson(Map<String, dynamic> json) {
//     return SmsInstance(
//       bank: json['bank'],
//       type: json['type'] == 'DEBIT' ? SmsType.DEBIT : SmsType.CREDIT,
//       amount: json['amount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'bank': bank,
//       'type': type == SmsType.DEBIT ? 'DEBIT' : 'CREDIT',
//       'amount': amount,
//     };
//   }
// }
