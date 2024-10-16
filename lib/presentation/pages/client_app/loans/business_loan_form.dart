import 'package:flutter/material.dart';
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/data/repositories/main_repository.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';
import 'package:vindhi_app/presentation/widgets/primary_textfield.dart';

class BusinessLoanForm extends StatefulWidget {
  const BusinessLoanForm({super.key});
  static const String routeName = "BusinessLoanForm";

  @override
  State<BusinessLoanForm> createState() => _BusinessLoanFormState();
}

class _BusinessLoanFormState extends State<BusinessLoanForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each field
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final pinCardNumberController = TextEditingController();
  final dobController = TextEditingController();
  final businessNameController = TextEditingController();
  final constitutionController = TextEditingController();
  final doiController = TextEditingController(); // Date of incorporation
  final turnoverController = TextEditingController();
  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  String? gender; // This can be a dropdown
  String? constitution; // This can be a dropdown
  bool? value = false;

  bool _isLoading = false;

  // Method to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        // Set the selected date to the controller in the desired format
        dobController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format to YYYY-MM-DD
      });
    }
  }

  // Method to show Date Picker
  Future<void> _selectIncorporationDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        // Set the selected date to the controller in the desired format
        doiController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format to YYYY-MM-DD
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await MainRepository(Api()).requestBusinessLoan(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          mobile: mobileController.text,
          pinCardNumber: pinCardNumberController.text,
          dateOfBirth: dobController.text,
          businessName: businessNameController.text,
          constitution: constitution!,
          dateOfIncorporation: doiController.text,
          annualTurnover: turnoverController.text,
          gender: gender!,
          residenceAddress: addressController.text,
          pinCode: pinCodeController.text,
          city: cityController.text,
          state: stateController.text,
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
                  'Your business loan request was submitted successfully.'),
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
        title: const Text('Business Loan',
            style: TextStyle(fontWeight: FontWeight.w400)),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset('assets/business_loan.jpg', height: 200),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: PrimaryTextField(
                                  hintText: "First Name",
                                  controller: firstNameController,
                                  validator: (value) => value!.isEmpty
                                      ? "Enter first name"
                                      : null,
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

                          // Gender (Dropdown or RadioButton)
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            value: gender,
                            hint: const Text("Gender"),
                            items: ['Male', 'Female', 'Other']
                                .map((label) => DropdownMenuItem(
                                      value: label,
                                      child: Text(label),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                            validator: (value) =>
                                value == null ? "Please select gender" : null,
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

                          // Date of Birth with Date Picker
                          PrimaryTextField(
                            hintText: "Date of Birth",
                            controller: dobController,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context); // Open date picker on tap
                            },
                            validator: (value) =>
                                value!.isEmpty ? "Enter date of birth" : null,
                          ),

                          const SizedBox(height: 10),

                          // Business Name
                          PrimaryTextField(
                            hintText: "Business Name",
                            controller: businessNameController,
                            validator: (value) =>
                                value!.isEmpty ? "Enter business name" : null,
                          ),

                          const SizedBox(height: 10),

                          // Constitution
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            value: constitution,
                            hint: const Text("Constitution"),
                            items: ['A', 'B', 'C']
                                .map((label) => DropdownMenuItem(
                                      value: label,
                                      child: Text(label),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                constitution = value;
                              });
                            },
                            validator: (value) => value == null
                                ? "Please select constitution"
                                : null,
                          ),

                          const SizedBox(height: 10),

                          // Date of Incorporation with Date Picker
                          PrimaryTextField(
                            hintText: "Date of Incorporation",
                            controller: doiController,
                            readOnly: true,
                            onTap: () {
                              _selectIncorporationDate(
                                  context); // Open date picker on tap
                            },
                            validator: (value) => value!.isEmpty
                                ? "Enter date of incorporation"
                                : null,
                          ),

                          const SizedBox(height: 10),

                          // Turnover
                          PrimaryTextField(
                            hintText: "Turnover",
                            controller: turnoverController,
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                value!.isEmpty ? "Enter turnover" : null,
                          ),

                          const SizedBox(height: 10),

                          // Address
                          PrimaryTextField(
                            hintText: "Address",
                            controller: addressController,
                            validator: (value) =>
                                value!.isEmpty ? "Enter address" : null,
                          ),

                          const SizedBox(height: 10),

                          // Pin Code
                          PrimaryTextField(
                            hintText: "Pin Code",
                            controller: pinCodeController,
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                value!.isEmpty ? "Enter pin code" : null,
                          ),

                          const SizedBox(height: 10),

                          // City
                          PrimaryTextField(
                            hintText: "City",
                            controller: cityController,
                            validator: (value) =>
                                value!.isEmpty ? "Enter city" : null,
                          ),

                          const SizedBox(height: 10),

                          // State
                          PrimaryTextField(
                            hintText: "State",
                            controller: stateController,
                            validator: (value) =>
                                value!.isEmpty ? "Enter state" : null,
                          ),

                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: value,
                                onChanged: (newValue) {
                                  setState(() {
                                    value =
                                        newValue!; // Directly assign the new value
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  "By Proceeding I agree to the terms and conditions",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Submit Button
                          PrimaryButton(
                            text: _isLoading ? "Submitting..." : "Submit",
                            onPressed: _isLoading ? null : _submitForm,
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
