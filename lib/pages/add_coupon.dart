import 'package:bloc_app/widgets/email_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';

class AddCouponScreen extends HookWidget {
  AddCouponScreen({super.key});

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
                          'Add a coupon',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text('Enter the code to get a points',
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/png/coupon.png',
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: 'code',
                      decoration: InputDecoration(
                          labelText: 'Coupon code',
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              Iconsax.ticket,
                            ),
                          )),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
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
                      child: const Text('Submit'),
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
