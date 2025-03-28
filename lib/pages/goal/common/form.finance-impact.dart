import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class FinanceImpactForm extends StatefulWidget {
  final FormInput totalMoney;
  final FormInput amountSaved;
  final FormInput timeSaved;
  final List<FormInputPair> incomeSources;
  final void Function() addIncomeSource;

  const FinanceImpactForm({
    super.key,
    required this.totalMoney,
    required this.amountSaved,
    required this.timeSaved,
    required this.incomeSources,
    required this.addIncomeSource,
  });

  @override
  State<FinanceImpactForm> createState() => _FinanceImpactFormState();
}

class _FinanceImpactFormState extends State<FinanceImpactForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: MediaQuery.of(context).size.width * 0.04,
      children: [
        DateSelector(
          hintText: widget.totalMoney.hint,
          controller: widget.totalMoney.controller,
          icon: Icons.calendar_today,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        ),
        Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            Expanded(
              child: TextFields(
                hinttext: widget.amountSaved.hint,
                whatIsInput: widget.amountSaved.type,
                controller: widget.amountSaved.controller,
              ),
            ),
            Expanded(
              child: TextFields(
                hinttext: widget.timeSaved.hint,
                whatIsInput: widget.timeSaved.type,
                controller: widget.timeSaved.controller,
              ),
            ),
          ],
        ),
        ...widget.incomeSources.map(
          (incomeSource) => Row(
            spacing: MediaQuery.of(context).size.width * 0.04,
            children: [
              Expanded(
                child: TextFields(
                  hinttext: incomeSource.key.hint,
                  whatIsInput: incomeSource.key.type,
                  controller: incomeSource.key.controller,
                ),
              ),
              Expanded(
                child: DateSelector(
                  hintText: incomeSource.value.hint,
                  controller: incomeSource.value.controller,
                  icon: Icons.calendar_today,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.addIncomeSource();
          },
          child: Text('Add Income Source'),
        ),
      ],
    );
  }
}
