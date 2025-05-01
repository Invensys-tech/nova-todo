import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final DateFormat dateFormat;

  DateSelector({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    DateFormat? dateFormat,
  }) : dateFormat = dateFormat ?? DateFormat('dd-MM-yyyy'),
       super(key: key);

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  final HiveService _hiveService = HiveService();

  String _dateType = 'Gregorian';

  void initAll() async {
    await _hiveService.initHive(boxName: 'dateTime');
    final stored = await _hiveService.getData('dateType');
    _dateType = stored == 'Ethiopian' ? 'Ethiopian' : 'Gregorian';

    print(_dateType);
  }

  @override
  void initState() {
    super.initState();
    initAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        readOnly: true,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),

          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.white54, width: 1.0),
              ),
            ),
            child: Icon(widget.icon, size: 20),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 50),
          hintText: widget.hintText,
          filled: true,

          fillColor: Theme.of(context).scaffoldBackgroundColor,
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey.withOpacity(.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
              color: Colors.green.withOpacity(.3),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.4),
              width: 1.0,
            ),
          ),
        ),
        onTap: () async {
          DateTime initDate =
              widget.controller.text.isNotEmpty
                  ? widget.dateFormat.parse(widget.controller.text)
                  : (widget.initialDate ?? DateTime.now());

          // DateTime initDate = initialDate ?? DateTime.now();
          DateTime? pickedDate = await showDatePicker(
            locale:
                _dateType == 'Ethiopian'
                    ? const Locale('am')
                    : const Locale('en'),
            context: context,
            initialDate:
                _dateType == 'Ethiopian'
                    ? DateTime.now().convertToEthiopian()
                    : initDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: Colors.green, // header background color
                    onPrimary: Colors.white, // header text color
                    surface:
                        Theme.of(context).primaryColorLight, // background color
                    onSurface: Colors.white70, // body text color
                  ),
                  dialogBackgroundColor: Colors.black,
                ),
                child: child ?? const SizedBox(),
              );
            },
          );
          if (pickedDate != null) {
            widget.controller.text = widget.dateFormat.format(pickedDate);
          }
        },
      ),
    );
  }
}
