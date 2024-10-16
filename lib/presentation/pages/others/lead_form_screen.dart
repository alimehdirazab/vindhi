import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vindhi_app/presentation/pages/auth/otp_screen.dart';
import 'package:vindhi_app/presentation/pages/others/lead_form_after_verify.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';
import 'dart:io';

import 'package:vindhi_app/presentation/widgets/primary_textfield.dart';

class LeadFormScreen extends StatefulWidget {
  const LeadFormScreen({super.key});

  static const String routeName = "leadFormScreen";

  @override
  State<LeadFormScreen> createState() => _LeadFormScreenState();
}

class _LeadFormScreenState extends State<LeadFormScreen> {
  final ImagePicker _picker = ImagePicker();
  final _formKey1 = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _gender;
  String? _maritalStatus;

  File? _selectedImage;

  // Function to pick image
  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  // Function to handle form submission
  void _submitForm1() {
    if (_formKey1.currentState!.validate()) {
      // Process the form data here (e.g., send it to an API)
      // Navigate to OTP verification screen
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => OtpScreen(
      //               phoneNumber: _phoneController.text.trim(),
      //               type: 'lead',
      //             )));

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LeadFormAfterVerify(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lead Form'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildBeforeOtp(),
        ),
      ),
    );
  }

  Widget _buildBeforeOtp() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey1,
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : null,
                  child: _selectedImage == null
                      ? const Icon(Icons.camera_alt,
                          color: Colors.grey, size: 30)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Full Name',
              controller: _fullNameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Email ID (optional)',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Phone No',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: const InputDecoration(
                hintText: 'Select Gender',
              ),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select gender' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Date of Birth',
              controller: _dobController,
              keyboardType: TextInputType.datetime,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your date of birth' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _maritalStatus,
              decoration: const InputDecoration(
                hintText: 'Marital Status',
              ),
              items: ['Single', 'Married', 'Divorced']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _maritalStatus = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select marital status' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Father Name',
              controller: _fatherNameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter father\'s name' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Mother Name',
              controller: _motherNameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter mother\'s name' : null,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              onPressed: _submitForm1,
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
