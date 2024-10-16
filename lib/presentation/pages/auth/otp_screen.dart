import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/core/ui.dart';
import 'package:vindhi_app/data/models/Otp%20Model/otp_response.dart';
import 'package:vindhi_app/data/repositories/main_repository.dart';
import 'package:vindhi_app/presentation/pages/home/home_page.dart';
import 'package:vindhi_app/presentation/pages/others/lead_form_after_verify.dart';
import 'package:vindhi_app/presentation/widgets/gap_widget.dart';
import 'package:vindhi_app/presentation/widgets/otp_box.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String type;
  const OtpScreen({super.key, required this.phoneNumber, this.type = ''});

  static const String routeName = "otpScreen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<TextEditingController> _controllers;
  bool _showResendButton = false;
  bool _isLoading = false;
  int _resendTimerSeconds = 45;
  late Timer _resendTimer;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
    startResendTimer();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _resendTimer.cancel();
    super.dispose();
  }

  void startResendTimer() {
    setState(() {
      _showResendButton = false;
    });

    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _resendTimerSeconds--;
        if (_resendTimerSeconds == 0) {
          _showResendButton = true;
          _resendTimer.cancel();
        }
      });
    });
  }

  Future<void> _verifyOtp() async {
    String otp1 = _controllers[0].text;
    String otp2 = _controllers[1].text;
    String otp3 = _controllers[2].text;
    String otp4 = _controllers[3].text;
    String otp5 = _controllers[4].text;
    String otp6 = _controllers[5].text;

    if (otp1.isEmpty ||
        otp2.isEmpty ||
        otp3.isEmpty ||
        otp4.isEmpty ||
        otp5.isEmpty ||
        otp6.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 151, 130, 128),
          content: Text('Please enter a valid OTP.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Call the API here
      OTPResponse response = await MainRepository(Api()).verifyOtp(
        otp1: otp1,
        otp2: otp2,
        otp3: otp3,
        otp4: otp4,
        otp5: otp5,
        otp6: otp6,
      );

      setState(() {
        _isLoading = false;
      });

      if (response.status == 200) {
        // Handle successful verification and navigate accordingly
        if (widget.type == 'lead') {
          Navigator.pushReplacementNamed(
              context, LeadFormAfterVerify.routeName);
        } else {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.message),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to verify OTP: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _handleResend() {
    setState(() {
      _resendTimerSeconds = 45;
      _showResendButton = false;
      startResendTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const GapWidget(size: 120), // Space for the top image
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset('assets/app_logo.png'),
                ),
                const GapWidget(size: 50),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'OTP has been sent to\n',
                        style: TextStyles.heading4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: widget.phoneNumber,
                        style: TextStyles.heading4.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' via SMS\n',
                        style: TextStyles.heading4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const GapWidget(),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) => Expanded(
                        child: OtpBox(
                          controller: _controllers[index],
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const GapWidget(),

                // Show loading or verify button
                _isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                        text: 'Verify',
                        onPressed: _verifyOtp,
                      ),

                const GapWidget(),
                _resendTimerSeconds != 0
                    ? Text(
                        '00:$_resendTimerSeconds',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                        ),
                      )
                    : const SizedBox(),
                if (_showResendButton)
                  TextButton(
                    onPressed: _handleResend,
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                const GapWidget(size: 70), // Space for the bottom image
              ],
            ),
          ),
        ),
      ),
    );
  }
}
