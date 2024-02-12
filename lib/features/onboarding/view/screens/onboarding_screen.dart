import 'package:ecommerce/core/components/custom_button.dart';
import 'package:ecommerce/features/login/view/screens/login_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/onboarding_character.png',
                  height: MediaQuery.sizeOf(context).height * 0.8,
                ),
              ),
              Positioned(
                top: 50,
                left: 24,
                child: Container(
                  width: MediaQuery.sizeOf(context).width - 48,
                  child: const Text(
                    'Define Yourself In Your Unique Way.',
                    style: TextStyle(
                        fontSize: 64, fontWeight: FontWeight.w500, height: 0.8),
                    softWrap: true,
                    maxLines: null,
                  ),
                ),
              ),
            ],
          )),
          CustomButton(
            label: 'Get Started',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
    ));
  }
}
