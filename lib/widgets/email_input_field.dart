import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';

class EmailInputField extends StatelessWidget {
  final String name;
  const EmailInputField({
    super.key,
    this.name = 'email',
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        name: name,
        decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: Theme.of(context).textTheme.labelMedium,
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Iconsax.user,
              ),
            )),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ]));
  }
}
