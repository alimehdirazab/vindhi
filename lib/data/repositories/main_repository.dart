import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/data/models/Banner/banner_model.dart';
import 'package:vindhi_app/data/models/Otp%20Model/otp_response.dart';

class MainRepository {
  final Api api;

  MainRepository(this.api);

  Future<ApiResponse> requestOtp(String employeeId) async {
    try {
      final response = await api.sendRequest.post(
        'send_otp',
        data: FormData.fromMap({'employee_id': employeeId}),
      );

      if (response.statusCode == 200 || response.statusCode == 404) {
        return ApiResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to request OTP: Unknown error');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<OTPResponse> verifyOtp({
    required String otp1,
    required String otp2,
    required String otp3,
    required String otp4,
    required String otp5,
    required String otp6,
  }) async {
    try {
      final response = await api.sendRequest.post(
        'api-varify-otp',
        data: FormData.fromMap(
          {
            'otp1': otp1,
            'otp2': otp2,
            'otp3': otp3,
            'otp4': otp4,
            'otp5': otp5,
            'otp6': otp6,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 404) {
        return OTPResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<BannerModel> fetchBanner() async {
    try {
      final response = await api.sendRequest.get('get-banner-api');

      if (response.statusCode == 200) {
        return BannerModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch banner');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> requestBusinessLoan({
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String mobile,
    required String pinCardNumber,
    required String dateOfBirth,
    required String businessName,
    required String constitution,
    required String dateOfIncorporation,
    required String annualTurnover,
    required String residenceAddress,
    required String pinCode,
    required String city,
    required String state,
  }) async {
    try {
      final response = await api.sendRequest.post(
        'request-for-business-loan',
        data: FormData.fromMap({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'gender': gender,
          'mobile': mobile,
          'pin_card_number': pinCardNumber,
          'date_of_birth': dateOfBirth,
          'business_name': businessName,
          'constitution': constitution,
          'date_of_incorporation': dateOfIncorporation,
          'annual_turnover': annualTurnover,
          'residence_address': residenceAddress,
          'pin_code': pinCode,
          'city': city,
          'state': state,
        }),
      );

      if (response.statusCode == 200) {
        print('Your request for a business loan submitted successfully');
      } else {
        throw Exception('Failed to request business loan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> requestProfessionalLoan({
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String mobile,
    required String pinCardNumber,
    required String dateOfBirth,
    required String netMonthlyIncome,
  }) async {
    try {
      final response = await api.sendRequest.post(
        'request-for-professional-loan',
        data: FormData.fromMap({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'gender': gender,
          'mobile': mobile,
          'pin_card_number': pinCardNumber,
          'date_of_birth': dateOfBirth,
          'net_monthly_income': netMonthlyIncome,
        }),
      );

      if (response.statusCode == 200) {
        print('Your request for a professional loan submitted successfully');
      } else {
        throw Exception('Failed to request professional loan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> requestPropertyLoan({
    required String firstName,
    required String lastName,
    required String email,
    required String applicantType,
    required String employmentType,
    required String mobile,
    required String pinCardNumber,
    required String typeOfProperty,
    required String netMonthlyIncome,
    required String propertyLocation,
    required String customerResidencePin,
    required File itrFilled, // File upload
  }) async {
    try {
      // Create FormData with MultipartFile for file
      FormData formData = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'applicant_type': applicantType,
        'employement_type': employmentType,
        'mobile': mobile,
        'pin_card_number': pinCardNumber,
        'type_of_property': typeOfProperty,
        'net_monthly_incom': netMonthlyIncome,
        'property_location': propertyLocation,
        'customer_residence_pin': customerResidencePin,
        'itr_filled': await MultipartFile.fromFile(
          itrFilled.path, // Path to the file
          filename: itrFilled.path.split('/').last, // File name
        ),
      });

      // Send the POST request
      final response = await api.sendRequest.post(
        'request-for-propert-loan',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Your request for a property loan was submitted successfully');
      } else {
        throw Exception('Failed to request property loan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> requestCarLoan({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String dateOfBirth,
    required String netMonthlyIncome,
    required String gender,
    required String pinCardNumber,
    required String residenceAddress,
    required String pinCode,
    required String city,
    required String state,
    required String purposeOfLoan,
    required String requiredLoanAmount,
    required String finalizedYourCar,
  }) async {
    try {
      final response = await api.sendRequest.post(
        'request-for-car-loan',
        data: FormData.fromMap({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'mobile': mobile,
          'date_of_birth': dateOfBirth,
          'net_monthly_income': netMonthlyIncome,
          'gender': gender,
          'pin_card_number': pinCardNumber,
          'residence_address': residenceAddress,
          'pin_code': pinCode,
          'city': city,
          'state': state,
          'purpose_of_loan': purposeOfLoan,
          'required_loan_amount': requiredLoanAmount,
          'finalized_your_car': finalizedYourCar,
        }),
      );

      if (response.statusCode == 200) {
        print('Your request for a car loan submitted successfully');
      } else {
        throw Exception('Failed to request car loan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> requestHomeLoan({
    required String fullName,
    required String panNumber,
    required String email,
    required String dateOfBirth,
    required String gender,
    required String maritalStatus,
    required String fatherName,
    required String motherName,
  }) async {
    try {
      final response = await api.sendRequest.post(
        'request-for-home-loan',
        data: FormData.fromMap({
          'full_name': fullName,
          'pan_number': panNumber,
          'email': email,
          'date_of_birth': dateOfBirth,
          'gender': gender,
          'Marital_status': maritalStatus,
          'father_name': fatherName,
          'mother_name': motherName,
        }),
      );

      if (response.statusCode == 200) {
        print('Your request for a home loan submitted successfully');
      } else {
        throw Exception('Failed to request home loan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> requestEducationLoan({
    required String fullName,
    required String panNumber,
    required String email,
    required String gender,
    required String dateOfBirth,
    required String maritalStatus,
    required String fatherName,
    required String motherName,
    required String pinCode,
    required bool abroadStudy,
  }) async {
    try {
      final response = await api.sendRequest.post(
        'request-for-esucation-loan',
        data: FormData.fromMap({
          'full_name': fullName,
          'pan_number': panNumber,
          'email': email,
          'gender': gender,
          'date_of_birth': dateOfBirth,
          'Marital_status': maritalStatus,
          'father_name': fatherName,
          'mother_name': motherName,
          'pin_code': pinCode,
          'abroad_study': abroadStudy,
        }),
      );

      if (response.statusCode == 200) {
        print('Your request for an education loan submitted successfully');
      } else {
        throw Exception('Failed to request education loan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
