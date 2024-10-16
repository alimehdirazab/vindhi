import 'package:flutter/material.dart';
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/data/repositories/main_repository.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';
import 'package:vindhi_app/presentation/widgets/primary_textfield.dart';

class EducationLoanForm extends StatefulWidget {
  const EducationLoanForm({super.key});
  static const routeName = 'educationloanform';

  @override
  State<EducationLoanForm> createState() => _EducationLoanFormState();
}

class _EducationLoanFormState extends State<EducationLoanForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each field
  final fullNameController = TextEditingController();
  final panNumberController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final pinCodeController = TextEditingController();

  String? gender; // Gender dropdown
  String? maritalStatus; // Marital Status dropdown
  bool abroadStudy = false; // Checkbox value
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
        await MainRepository(Api()).requestEducationLoan(
          fullName: fullNameController.text,
          panNumber: panNumberController.text,
          email: emailController.text,
          gender: gender!,
          dateOfBirth: dobController.text,
          maritalStatus: maritalStatus!,
          fatherName: fatherNameController.text,
          motherName: motherNameController.text,
          pinCode: pinCodeController.text,
          abroadStudy: abroadStudy,
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
                  'Your Education loan request was submitted successfully.'),
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
        title: const Text('Education Loan Form',
            style: TextStyle(fontWeight: FontWeight.w400)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/education_loan.jpg', height: 200),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Full Name
                      PrimaryTextField(
                        hintText: "Full Name",
                        controller: fullNameController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter full name" : null,
                      ),

                      const SizedBox(height: 10),

                      // PAN Number
                      PrimaryTextField(
                        hintText: "PAN Number",
                        controller: panNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter PAN number" : null,
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

                      // Marital Status (Dropdown)
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
                        value: maritalStatus,
                        hint: const Text("Marital Status"),
                        items: ['Single', 'Married', 'Divorced', 'Widowed']
                            .map((label) => DropdownMenuItem(
                                  value: label,
                                  child: Text(label),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            maritalStatus = value;
                          });
                        },
                        validator: (value) => value == null
                            ? "Please select marital status"
                            : null,
                      ),

                      const SizedBox(height: 10),

                      // Father's Name
                      PrimaryTextField(
                        hintText: "Father's Name",
                        controller: fatherNameController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter father's name" : null,
                      ),

                      const SizedBox(height: 10),

                      // Mother's Name
                      PrimaryTextField(
                        hintText: "Mother's Name",
                        controller: motherNameController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter mother's name" : null,
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

                      // Abroad Study (Checkbox)
                      Row(
                        children: [
                          Checkbox(
                            value: abroadStudy,
                            onChanged: (newValue) {
                              setState(() {
                                abroadStudy = newValue!;
                              });
                            },
                          ),
                          Flexible(
                            child: Text(
                              "Planning to study abroad",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                        ],
                      ),

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
