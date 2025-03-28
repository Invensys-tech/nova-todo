import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
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
      spacing: 3.2,
      children: [
        TextFields(
          hinttext: widget.totalMoney.hint,
          whatIsInput: widget.totalMoney.type,
          controller: widget.totalMoney.controller,
        ),
        TextFields(
          hinttext: widget.amountSaved.hint,
          whatIsInput: widget.amountSaved.type,
          controller: widget.amountSaved.controller,
        ),
        TextFields(
          hinttext: widget.timeSaved.hint,
          whatIsInput: widget.timeSaved.type,
          controller: widget.timeSaved.controller,
        ),
        ...widget.incomeSources.map(
          (incomeSource) => Row(
            spacing: 3.2,
            children: [
              TextFields(
                hinttext: incomeSource.key.hint,
                whatIsInput: incomeSource.key.type,
                controller: incomeSource.key.controller,
              ),
              TextFields(
                hinttext: incomeSource.value.hint,
                whatIsInput: incomeSource.value.type,
                controller: incomeSource.value.controller,
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
