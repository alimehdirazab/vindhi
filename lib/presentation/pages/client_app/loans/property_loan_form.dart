import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Add this import
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/data/repositories/main_repository.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';
import 'package:vindhi_app/presentation/widgets/primary_textfield.dart';

class PropertyLoanForm extends StatefulWidget {
  const PropertyLoanForm({super.key});
  static const String routeName = 'propertyloanform';

  @override
  State<PropertyLoanForm> createState() => _PropertyLoanFormState();
}

class _PropertyLoanFormState extends State<PropertyLoanForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each field
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final pinCardNumberController = TextEditingController();
  final netMonthlyIncomeController = TextEditingController();
  final propertyLocationController = TextEditingController();
  final customerResidencePinController = TextEditingController();
  final itrFilledController =
      TextEditingController(); // Text field for ITR Filled

  String? applicantType; // Dropdown for applicant type
  String? employmentType; // Dropdown for employment type
  String? typeOfProperty; // Dropdown for type of property
  bool value = false; // Checkbox for terms and conditions
  bool _isLoading = false;
  PlatformFile? _itrFile; // Variable to hold the selected file

  // File picker for selecting ITR file
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png', 'doc', 'docx'],
      type: FileType.custom,
    );

    if (result != null) {
      setState(() {
        _itrFile = result.files.first;
        itrFilledController.text =
            _itrFile!.name; // Show file name in text field
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_itrFile == null) {
        // Show error if no file is selected
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please upload a valid ITR file.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        // Convert PlatformFile to File using the file's path
        File itrFile = File(_itrFile!.path!);
        await MainRepository(Api()).requestPropertyLoan(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          applicantType: applicantType!,
          employmentType: employmentType!,
          mobile: mobileController.text,
          pinCardNumber: pinCardNumberController.text,
          typeOfProperty: typeOfProperty!,
          netMonthlyIncome: netMonthlyIncomeController.text,
          propertyLocation: propertyLocationController.text,
          customerResidencePin: customerResidencePinController.text,
          itrFilled: itrFile, // Pass file path
        );

        setState(() {
          _isLoading = false;
        });

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text(
                  'Your Property loan request was submitted successfully.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(); // Pop the screen
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to submit request: $e'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Loan',
            style: TextStyle(fontWeight: FontWeight.w400)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/property_loan.jpg', height: 200),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // First and Last Name
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryTextField(
                              hintText: "First Name",
                              controller: firstNameController,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter first name" : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PrimaryTextField(
                              hintText: "Last Name",
                              controller: lastNameController,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter last name" : null,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Email
                      PrimaryTextField(
                        hintText: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? "Enter email" : null,
                      ),

                      const SizedBox(height: 10),

                      // Applicant Type (Dropdown)
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                        ),
                        value: applicantType,
                        hint: const Text("Applicant Type"),
                        items: ['Individual', 'Joint', 'Business']
                            .map((label) => DropdownMenuItem(
                                  value: label,
                                  child: Text(label),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            applicantType = value;
                          });
                        },
                        validator: (value) => value == null
                            ? "Please select applicant type"
                            : null,
                      ),

                      const SizedBox(height: 10),

                      // Employment Type (Dropdown)
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                        ),
                        value: employmentType,
                        hint: const Text("Employment Type"),
                        items: ['Salaried', 'Self-employed']
                            .map((label) => DropdownMenuItem(
                                  value: label,
                                  child: Text(label),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            employmentType = value;
                          });
                        },
                        validator: (value) => value == null
                            ? "Please select employment type"
                            : null,
                      ),

                      const SizedBox(height: 10),

                      // Mobile
                      PrimaryTextField(
                        hintText: "Mobile",
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.isEmpty ? "Enter mobile number" : null,
                      ),

                      const SizedBox(height: 10),

                      // Pin Card Number
                      PrimaryTextField(
                        hintText: "PIN Card Number",
                        controller: pinCardNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter PIN card number" : null,
                      ),

                      const SizedBox(height: 10),

                      // Type of Property (Dropdown)
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                        ),
                        value: typeOfProperty,
                        hint: const Text("Type of Property"),
                        items: ['Residential', 'Commercial']
                            .map((label) => DropdownMenuItem(
                                  value: label,
                                  child: Text(label),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            typeOfProperty = value;
                          });
                        },
                        validator: (value) => value == null
                            ? "Please select type of property"
                            : null,
                      ),

                      const SizedBox(height: 10),

                      // Net Monthly Income
                      PrimaryTextField(
                        hintText: "Net Monthly Income",
                        controller: netMonthlyIncomeController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter net monthly income" : null,
                      ),

                      const SizedBox(height: 10),

                      // Property Location
                      PrimaryTextField(
                        hintText: "Property Location",
                        controller: propertyLocationController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter property location" : null,
                      ),

                      const SizedBox(height: 10),

                      // Customer Residence Pin
                      PrimaryTextField(
                        hintText: "Customer Residence Pin",
                        controller: customerResidencePinController,
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty
                            ? "Enter customer residence pin"
                            : null,
                      ),

                      const SizedBox(height: 10),

                      // ITR Filled
                      PrimaryTextField(
                        hintText: "Upload ITR File",
                        controller: itrFilledController,
                        readOnly: true,
                        onTap: _pickFile,
                        validator: (value) => _itrFile == null
                            ? "Please upload a valid ITR file"
                            : null,
                      ),
                      if (_itrFile != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Selected file: ${_itrFile!.name}",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),

                      const SizedBox(height: 20),

                      // Terms and Conditions Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: value,
                            onChanged: (bool? newValue) {
                              setState(() {
                                value = newValue!;
                              });
                            },
                          ),
                          const Text("I agree to the terms and conditions")
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Submit Button
                      _isLoading
                          ? const CircularProgressIndicator()
                          : PrimaryButton(
                              text: "Submit",
                              onPressed: _submitForm,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
