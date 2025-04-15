import 'package:flutter/material.dart';

class StepperForm extends StatefulWidget {
  const StepperForm({super.key});

  @override
  State<StepperForm> createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  int _currentStep = 0;

  List<Step> steps() => [
    Step(
      title: Text('Step 1'),
      content: Center(child: Text('Page Step 1')),
      isActive: _currentStep == 0,
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
    ),
    Step(
      title: Text('Step 2'),
      content: Center(child: Text('Page Step 2')),
      isActive: _currentStep == 1,
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
    ),
    Step(
      title: Text('Step 3'),
      content: Center(child: Text('Page Step 3')),
      isActive: _currentStep == 2,
      state: _currentStep <= 2 ? StepState.editing : StepState.complete,
    ),
  ];

  continueStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep += 1;
      }
    });
  }

  cancelStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        steps: steps(),
        currentStep: _currentStep,
        type: StepperType.horizontal,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
      ),
    );
  }
}
