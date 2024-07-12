import 'package:bloc_app/widgets/email_input_field.dart';
import 'package:bloc_app/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetNewPassScreen extends HookWidget {
  SetNewPassScreen({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ListView(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            // SvgPicture.asset(
            //   'assets/svg/bg.svg',
            //   fit: BoxFit.cover,
            // ),
            SizedBox(
              width: .8 * screenWidth,
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Set a new password',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                            'Please enter your new password and confirm it to reset your password',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Image.asset('assets/png/forget_password.png'),
                    const SizedBox(height: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PasswordInputField(),
                        SizedBox(height: 15),
                        PasswordInputField(
                          name: 'confirm_password',
                          label: 'Confirm Password',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          print(formKey.currentState!.value);
                        }
                      },
                      style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
