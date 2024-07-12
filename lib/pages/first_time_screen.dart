import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class FirstTimeScreen extends HookWidget {
  const FirstTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
              child: SvgPicture.asset(
            'assets/svg/welcome_bg.svg',
            semanticsLabel: 'Acme Logo',
            height: screenHeight - statusBarHeight,
          )),
          SizedBox(
            width: .8 * screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/png/welcome_avatar.png',
                  width: 180,
                ),
                Text(
                  'Grow Your Education & level up with Turbo Platform',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/dots.svg',
                      semanticsLabel: 'Dots',
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(70, 70),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {},
                        child: const Icon(
                          Iconsax.play,
                          size: 30,
                          color: Color(0xFFFF005C),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
