import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void onGo() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              width: 150,
              height: 150,
            ),
            const CustomText(
              text: "Let's get started",
              style: CustomTextStyle.title,
            ),
            const SizedBox(height: 8),
            const CustomText(
              text: "Never a better time than now to start",
              style: CustomTextStyle.subtitle,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Get Started",  
                buttonType: ButtonType.fill,
                onPressed: onGo,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
