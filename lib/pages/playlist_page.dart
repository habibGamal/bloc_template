import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';

class PlaylistPage extends HookWidget {
  PlaylistPage({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FittedBox(
            child: Text(
              'Playlist Name',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.add_circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1265',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        'assets/png/coins.png',
                        width: 40,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    name: 'search',
                    decoration: InputDecoration(
                        labelText: 'What are you looking for?',
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Iconsax.search_normal,
                          ),
                        )),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(
                            'assets/png/video_bg.png',
                            width: 200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(
                              'Video Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 22,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(Iconsax.lock_circle,
                                    color: Colors.red[300]),
                                const SizedBox(width: 5),
                                Text(
                                  '• Buy it first',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                            trailing: FilledButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    '30 ',
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      borderRadius: BorderRadius.circular(9999),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Image.asset(
                                      'assets/png/coins.png',
                                      width: 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(
                            'assets/png/video_bg.png',
                            width: 200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(
                              'Video Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 22,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(
                                  Iconsax.unlock,
                                  color: Colors.green[300],
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '• Watch it now',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Iconsax.play_circle,
                                color: Theme.of(context).colorScheme.primary,
                                size: 40,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
