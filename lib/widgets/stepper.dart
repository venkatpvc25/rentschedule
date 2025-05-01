import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final List<CustomStep> steps;
  final int currentStep;
  final Function(int)? onStepTapped;
  final Function()? onStepContinue;
  final Function()? onStepCancel;
  final Widget? controlsBuilder;

  const CustomStepper({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.steps.length,
            itemBuilder: (context, index) {
              final step = widget.steps[index];
              final isActive = index == widget.currentStep;
              final isCompleted = index < widget.currentStep;
              final isFirst = index == 0;
              final isLast = index == widget.steps.length - 1;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Indicator
                      _buildIndicator(index + 1, isActive, isCompleted),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap:
                                  widget.onStepTapped != null
                                      ? () => widget.onStepTapped!(index)
                                      : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isActive
                                              ? Theme.of(context).primaryColor
                                              : Colors.black87,
                                    ),
                                  ),
                                  if (step.subtitle != null)
                                    Text(
                                      step.subtitle!,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                ],
                              ),
                            ),
                            if (isActive)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: step.content,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 14.0,
                      ), // Adjust to align with the vertical line
                      child: SizedBox(
                        height: 40.0, // Adjust the height of the line
                        child: VerticalDivider(
                          thickness: 1.0,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16.0), // Space between steps
                ],
              );
            },
          ),
        ),
        if (widget.controlsBuilder != null &&
            widget.currentStep < widget.steps.length)
          widget.controlsBuilder!,
        if (widget.controlsBuilder == null &&
            widget.currentStep < widget.steps.length)
          _buildDefaultControls(),
      ],
    );
  }

  Widget _buildIndicator(int stepNumber, bool isActive, bool isCompleted) {
    if (isCompleted) {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green, // Or your preferred completed color
        ),
        child: const Center(
          child: Icon(Icons.check, color: Colors.white, size: 16.0),
        ),
      );
    } else if (isActive) {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor, // Your active color
        ),
        child: Center(
          child: Text(
            '$stepNumber',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Center(
          child: Text(
            '$stepNumber',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14.0),
          ),
        ),
      );
    }
  }

  Widget _buildDefaultControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.currentStep > 0 && widget.onStepCancel != null)
            TextButton(
              onPressed: widget.onStepCancel,
              child: const Text('Go Back'),
            ),
          const SizedBox(width: 8.0),
          if (widget.currentStep < widget.steps.length - 1 &&
              widget.onStepContinue != null)
            ElevatedButton(
              onPressed: widget.onStepContinue,
              child: const Text('Next Step'),
            ),
          if (widget.currentStep == widget.steps.length - 1 &&
              widget.onStepContinue != null)
            ElevatedButton(
              onPressed: widget.onStepContinue,
              child: const Text('Complete'),
            ),
        ],
      ),
    );
  }
}

class CustomStep {
  final String title;
  final String? subtitle;
  final Widget content;

  const CustomStep({required this.title, this.subtitle, required this.content});
}
