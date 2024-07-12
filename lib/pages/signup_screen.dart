import 'package:bloc_app/constants/colors.dart';
import 'package:bloc_app/widgets/divider_text.dart';
import 'package:bloc_app/widgets/email_input_field.dart';
import 'package:bloc_app/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends HookWidget {
  SignupScreen({super.key});

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
                  children: [
                    const SizedBox(height: 60),
                    Column(
                      children: [
                        Text(
                          'Turbo',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Text('Increase Your Education Level',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                )),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FormBuilderTextField(
                          name: 'username',
                          decoration: InputDecoration(
                              labelText: 'Your name',
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(
                                  Iconsax.personalcard,
                                ),
                              )),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(3),
                            FormBuilderValidators.maxLength(20),
                          ]),
                        ),
                        const SizedBox(height: 15),
                        const EmailInputField(),
                        const SizedBox(height: 15),
                        FormBuilderDropdown(
                          name: 'classroom',
                          decoration: InputDecoration(
                              labelText: 'Your Classroom',
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(
                                  Iconsax.teacher,
                                ),
                              )),
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text("classroom 1"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("classroom 2"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const PasswordInputField(),
                        const SizedBox(height: 15),
                        const PasswordInputField(
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
                      child: const Text('Signup'),
                    ),
                    const SizedBox(height: 10),
                    const DividerText(text: "OR"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('login'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/svg/google.svg',
                            width: 50,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/svg/facebook.svg',
                            height: 50,
                          ),
                        ),
                      ],
                    )
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
