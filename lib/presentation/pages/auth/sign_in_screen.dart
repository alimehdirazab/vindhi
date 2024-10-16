import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/data/repositories/main_repository.dart';
import 'package:vindhi_app/presentation/pages/auth/otp_screen.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';
import 'package:vindhi_app/presentation/widgets/primary_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = "signInScreen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoading = false;

  // Function to request OTP
  Future<void> _requestOtp() async {
    // Validate Employee ID before making the request
    if (_phoneNumberController.text.trim().isEmpty) {
      // Show error if the Employee ID is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your Employee ID.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show loading spinner
    setState(() {
      _isLoading = true;
    });

    try {
      // Assuming you have an auth repository to handle API calls
      ApiResponse response = await MainRepository(Api())
          .requestOtp(_phoneNumberController.text.trim());

      if (response.status == 200) {
        // Navigate to OTP screen if the response is successful
        Navigator.pushNamed(context, OtpScreen.routeName,
            arguments: _phoneNumberController.text.trim());
      } else {
        // Show error message if the response indicates failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle error (e.g., network issue, unexpected response)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Hide loading spinner
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/app_logo.png', height: 30),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animation
              Lottie.asset('assets/animation2.json', height: 250, width: 250),
              const SizedBox(height: 100),
              // Input field for Employee ID
              PrimaryTextField(
                controller: _phoneNumberController,
                hintText: 'Enter your Employee ID',
                icon: Icons.person,
              ),
              const SizedBox(height: 50),
              // Log In button
              SizedBox(
                width: 300,
                child: PrimaryButton(
                  onPressed: _isLoading
                      ? null
                      : _requestOtp, // Disable button while loading
                  text: _isLoading ? '......' : 'Log In',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
