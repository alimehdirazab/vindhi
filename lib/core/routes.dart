import 'package:flutter/cupertino.dart';
import 'package:vindhi_app/presentation/pages/auth/otp_screen.dart';
import 'package:vindhi_app/presentation/pages/auth/select_sign_in_option_screen.dart';
import 'package:vindhi_app/presentation/pages/auth/sign_in_screen.dart';
import 'package:vindhi_app/presentation/pages/client_app/home/client_home_page.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/business_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/car_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/education_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/home_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/professional_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/property_loan_form.dart';
import 'package:vindhi_app/presentation/pages/home/home_page.dart';
import 'package:vindhi_app/presentation/pages/home/profile_screen.dart';
import 'package:vindhi_app/presentation/pages/others/lead_form_after_verify.dart';
import 'package:vindhi_app/presentation/pages/others/lead_form_screen.dart';
import 'package:vindhi_app/presentation/pages/others/notification_screen.dart';
import 'package:vindhi_app/presentation/pages/splash_screen.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case SignInScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SignInScreen(),
        );

      case OtpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) =>
              OtpScreen(phoneNumber: settings.arguments as String),
        );

      case HomePage.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomePage(),
        );

      case LeadFormScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const LeadFormScreen(),
        );

      case LeadFormAfterVerify.routeName:
        return CupertinoPageRoute(
          builder: (context) => const LeadFormAfterVerify(),
        );

      case NotificationScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const NotificationScreen(),
        );

      case ProfileScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const ProfileScreen(),
        );

      case ClientHomePage.routeName:
        return CupertinoPageRoute(
          builder: (context) => const ClientHomePage(),
        );

      case BusinessLoanForm.routeName:
        return CupertinoPageRoute(
          builder: (context) => const BusinessLoanForm(),
        );

      case ProfessionalLoanForm.routeName:
        return CupertinoPageRoute(
          builder: (context) => const ProfessionalLoanForm(),
        );

      case PropertyLoanForm.routeName:
        return CupertinoPageRoute(
          builder: (context) => const PropertyLoanForm(),
        );

      case CarLoanForm.routeName:
        return CupertinoPageRoute(
          builder: (context) => const CarLoanForm(),
        );

      case HomeLoanForm.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeLoanForm(),
        );

      case EducationLoanForm.routeName:
        return CupertinoPageRoute(
          builder: (context) => const EducationLoanForm(),
        );

      case SelectSignInOptionScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SelectSignInOptionScreen(),
        );

      default:
        return null;
    }
  }
}
