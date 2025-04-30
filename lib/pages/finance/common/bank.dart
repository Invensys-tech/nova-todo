import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/bank/SingleBankFullviewPage.dart';

class BankWidget extends StatefulWidget {
  const BankWidget({
    super.key,
    required this.accountname,
    required this.accoutnumber,
    required this.balance,
    required this.id,
    required this.datamanager,
  });

  final String accountname;
  final num accoutnumber;
  final num balance;
  final int id;
  final Datamanager datamanager;

  @override
  State<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends State<BankWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => Singlebankfullviewpage(
                  id: widget.id,
                  name: widget.accountname,
                  datamanager: widget.datamanager,
                ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.073,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.003,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5), // Choose your color and opacity
                BlendMode.modulate, // Or try `BlendMode.color` or others
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.height * 0.045,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      "https://combanketh.et/cbeapi/uploads/logo_1ae2fb1df4.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.035),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  '${widget.accountname}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
                Text(
                  '${widget.accoutnumber}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Spacer(),
            Text(
              '${widget.balance}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
