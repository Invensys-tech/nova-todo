import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class FinanceImpactForm extends StatefulWidget {
  final FormInput totalMoney;
  final FormInput amountSaved;
  final FormInput timeSaved;
  final FormInput incomeSource;
  // final List<FormInputPair> incomeSources;
  final void Function() addIncomeSource;

  const FinanceImpactForm({
    super.key,
    required this.totalMoney,
    required this.amountSaved,
    required this.timeSaved,
    required this.incomeSource,
    // required this.incomeSources,
    required this.addIncomeSource,
  });

  @override
  State<FinanceImpactForm> createState() => _FinanceImpactFormState();
}

class _FinanceImpactFormState extends State<FinanceImpactForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFF27272A)),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0x00000000),
      ),
      child: Column(
        spacing: MediaQuery.of(context).size.width * 0.04,
        children: [
          MyTextInput(
            label: widget.totalMoney.label,
            textFields: TextFields(
              hinttext: widget.totalMoney.hint,
              controller: widget.totalMoney.controller,
              whatIsInput: widget.totalMoney.type,
            ),
          ),
          MyTextInput(
            label: widget.amountSaved.label,
            textFields: TextFields(
              hinttext: widget.amountSaved.hint,
              whatIsInput: widget.amountSaved.type,
              controller: widget.amountSaved.controller,
            ),
          ),
          MyTextInput(
            label: widget.incomeSource.label,
            textFields: TextFields(
              hinttext: widget.incomeSource.hint,
              whatIsInput: widget.incomeSource.type,
              controller: widget.incomeSource.controller,
            ),
          ),
          // Row(
          //   spacing: MediaQuery.of(context).size.width * 0.04,
          //   children: [
          //     Expanded(
          //       child: TextFields(
          //         hinttext: widget.amountSaved.hint,
          //         whatIsInput: widget.amountSaved.type,
          //         controller: widget.amountSaved.controller,
          //       ),
          //     ),
          //     Expanded(
          //       child: TextFields(
          //         hinttext: widget.timeSaved.hint,
          //         whatIsInput: widget.timeSaved.type,
          //         controller: widget.timeSaved.controller,
          //       ),
          //     ),
          //   ],
          // ),
          // ...widget.incomeSources.map(
          //   (incomeSource) => Row(
          //     spacing: MediaQuery.of(context).size.width * 0.04,
          //     children: [
          //       Expanded(
          //         child: TextFields(
          //           hinttext: incomeSource.key.hint,
          //           whatIsInput: incomeSource.key.type,
          //           controller: incomeSource.key.controller,
          //         ),
          //       ),
          //       Expanded(
          //         child: TextFields(
          //           hinttext: incomeSource.value.hint,
          //           controller: incomeSource.value.controller,
          //           whatIsInput: incomeSource.value.type,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     widget.addIncomeSource();
          //   },
          //   child: Text('Add Income Source'),
          // ),
        ],
      ),
    );
  }
}
