import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';

class PasswordInputField extends HookWidget {
  final String name;
  final String label;
  const PasswordInputField({
    super.key,
    this.name = 'password',
    this.label = 'Password',
  });

  @override
  Widget build(BuildContext context) {
    final passwordInvisible = useState(true);
    return FormBuilderTextField(
        name: name,
        obscureText: passwordInvisible.value,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: Theme.of(context).textTheme.labelMedium,
            suffixIcon: IconButton(
              icon: Icon(
                  passwordInvisible.value ? Iconsax.eye_slash : Iconsax.eye),
              onPressed: () {
                passwordInvisible.value = !passwordInvisible.value;
              },
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Iconsax.password_check,
              ),
            )),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(8),
          FormBuilderValidators.maxLength(20),
        ]));
  }
}
