import 'dart:io';

 import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../styles/colors/app_colors.dart';
import '../styles/text_styles/app_text_styles.dart';

class Sample2 extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool isPassword;
  final bool isEnabled;
  final void Function(String)? fn;
  const Sample2({
    Key? key,
    required this.title,
    required this.controller,
    required this.validator,
    this.isPassword = false,
    this.isEnabled = true,
    this.fn,
  }) : super(key: key);

  @override
  State<Sample2> createState() => _Sample2State();
}

class _Sample2State extends State<Sample2> {
  bool isSecure = false;
  @override
  void initState() {
    super.initState();
    isSecure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyles.font16BlackMedium(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            FancyPasswordField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.lighterGray,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSecure = !isSecure;
                      });
                    },
                    icon: Icon(
                      isSecure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.black,
                    ),
                  )
                      : null),
              validationRules: {
                UppercaseValidationRule(
                  customText:  'Password must contain at least 1 Upper character'

                ),
                LowercaseValidationRule(
                    customText: 'Password must contain at least 1 lower character'

                ),
                DigitValidationRule(
                    customText:'Password must contain at least 1 number'

                ),
                SpecialCharacterValidationRule(
                    customText:'Password must contain at least 1 special character(&,\$,#,..)'

                ),
                MinCharactersValidationRule(8,
                    customText: 'Password length must be at least 8'),

              },
              controller: widget.controller,
              validator: widget.validator,
              strengthIndicatorBuilder: (strength) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: StepProgressIndicator(
                    totalSteps: 8,
                    currentStep: getStep(strength),
                    selectedColor: getColor(strength)!,
                    unselectedColor: Colors.grey[300]!,
                  ),
                );
              },
              validationRuleBuilder: (rules, value) {
                return Wrap(
                  runSpacing: 8,
                  spacing: 4,
                  children: rules.map(
                        (rule) {
                      final ruleValidated = rule.validate(value);
                      return Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (ruleValidated) ...[
                              const Icon(
                                Icons.check,
                                color: Color(0xFF0A9471),
                              ),
                              const SizedBox(width: 2),
                            ],
                            Text(
                              rule.name,
                              style: TextStyle(
                                color: ruleValidated
                                    ? const Color(0xFF0A9471)
                                    : const Color(0xFF9A9FAF),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: ruleValidated
                            ? const Color(0xFFD0F7ED)
                            : const Color(0xFFF4F5F6),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  int getStep(double strength) {
    if (strength == 0) {
      return 0;
    } else if (strength < .1) {
      return 1;
    } else if (strength < .2) {
      return 2;
    } else if (strength < .3) {
      return 3;
    } else if (strength < .4) {
      return 4;
    } else if (strength < .5) {
      return 5;
    } else if (strength < .6) {
      return 6;
    } else if (strength < .7) {
      return 7;
    }
    return 8;
  }

  Color? getColor(double strength) {
    if (strength == 0) {
      return Colors.grey[300];
    } else if (strength < .1) {
      return Colors.red;
    } else if (strength < .2) {
      return Colors.red;
    } else if (strength < .3) {
      return Colors.yellow;
    } else if (strength < .4) {
      return Colors.yellow;
    } else if (strength < .5) {
      return Colors.yellow;
    } else if (strength < .6) {
      return Colors.green;
    } else if (strength < .7) {
      return Colors.green;
    }
    return Colors.green;
  }
}
