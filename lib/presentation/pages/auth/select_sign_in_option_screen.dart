import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vindhi_app/presentation/pages/auth/sign_in_screen.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';

class SelectSignInOptionScreen extends StatelessWidget {
  const SelectSignInOptionScreen({super.key});
  static const String routeName = 'select_sign_in_option_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Sign In Option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.asset('assets/select_auth_option_ani.json',
            //     height: 250, width: 250),
            // const SizedBox(height: 170),
            // Text(
            //   'Plz Select Your Role To Log In',
            //   style: Theme.of(context).textTheme.bodyLarge,
            // ),
            const SizedBox(height: 30),
            PrimaryButton(
              fixedSize: const Size(300, 40),
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
              text: 'Employee',
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              fixedSize: const Size(300, 40),
              onPressed: () {},
              text: 'Frinchise',
            ),
          ],
        ),
      ),
    );
  }
}
