import 'package:flutter/material.dart';
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/data/repositories/main_repository.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';
import 'package:vindhi_app/presentation/widgets/primary_textfield.dart';

class ProfessionalLoanForm extends StatefulWidget {
  const ProfessionalLoanForm({super.key});
  static const String routeName = "ProfessionalLoanForm";

  @override
  State<ProfessionalLoanForm> createState() => _ProfessionalLoanFormState();
}

class _ProfessionalLoanFormState extends State<ProfessionalLoanForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each field
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final pinCardNumberController = TextEditingController();
  final dobController = TextEditingController();
  final netMonthlyIncomeController = TextEditingController();

  String? gender; // Gender can be a dropdown
  bool value = false; // Checkbox value
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await MainRepository(Api()).requestProfessionalLoan(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          gender: gender!,
          mobile: mobileController.text,
          pinCardNumber: pinCardNumberController.text,
          dateOfBirth: dobController.text,
          netMonthlyIncome: netMonthlyIncomeController.text,
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
                  'Your Professional loan request was submitted successfully.'),
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
        title: const Text('Professional Loan',
            style: TextStyle(fontWeight: FontWeight.w400)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/professional_loan.jpg', height: 200),
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

                      // Gender (Dropdown)
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

                      // Net Monthly Income
                      PrimaryTextField(
                        hintText: "Net Monthly Income",
                        controller: netMonthlyIncomeController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter net monthly income" : null,
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
