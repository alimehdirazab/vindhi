import 'package:flutter/material.dart';
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/data/repositories/main_repository.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';
import 'package:vindhi_app/presentation/widgets/primary_textfield.dart';

class CarLoanForm extends StatefulWidget {
  const CarLoanForm({super.key});
  static const routeName = 'carloanform';

  @override
  State<CarLoanForm> createState() => _CarLoanFormState();
}

class _CarLoanFormState extends State<CarLoanForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each field
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final pinCardNumberController = TextEditingController();
  final dobController = TextEditingController();
  final netMonthlyIncomeController = TextEditingController();
  final residenceAddressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final purposeOfLoanController = TextEditingController();
  final loanAmountController = TextEditingController();

  String? gender; // Gender dropdown
  String? carColor; // Car color dropdown
  bool value = false; // Checkbox value

  bool _isLoading = false;

  // List of car colors
  final List<String> carColors = ['Red', 'Blue', 'Black', 'White', 'Grey'];

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
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await MainRepository(Api()).requestCarLoan(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          mobile: mobileController.text,
          city: cityController.text,
          dateOfBirth: dobController.text,
          finalizedYourCar: carColor!,
          gender: gender!,
          netMonthlyIncome: netMonthlyIncomeController.text,
          pinCardNumber: pinCardNumberController.text,
          pinCode: pinCodeController.text,
          purposeOfLoan: purposeOfLoanController.text,
          requiredLoanAmount: loanAmountController.text,
          residenceAddress: residenceAddressController.text,
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
                  'Your Car loan request was submitted successfully.'),
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
        title: const Text('Car Loan Form',
            style: TextStyle(fontWeight: FontWeight.w400)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/car_loan.jpg', height: 200),
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

                      // Gender Dropdown
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

                      // Date of Birth with Date Picker
                      PrimaryTextField(
                        hintText: "Date of Birth",
                        controller: dobController,
                        readOnly: true,
                        onTap: () {
                          _selectDate(context);
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

                      const SizedBox(height: 10),

                      // Residence Address
                      PrimaryTextField(
                        hintText: "Residence Address",
                        controller: residenceAddressController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter residence address" : null,
                      ),

                      const SizedBox(height: 10),

                      // Pin Card Number
                      PrimaryTextField(
                        hintText: "Pin Card Number",
                        keyboardType: TextInputType.number,
                        controller: pinCardNumberController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter Pin Card Number " : null,
                      ),

                      const SizedBox(height: 10),

                      // Pin Code
                      PrimaryTextField(
                        hintText: "PIN Code",
                        controller: pinCodeController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter PIN code" : null,
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

                      const SizedBox(height: 10),

                      // Purpose of Loan
                      PrimaryTextField(
                        hintText: "Purpose of Loan",
                        controller: purposeOfLoanController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter purpose of loan" : null,
                      ),

                      const SizedBox(height: 10),

                      // Loan Amount
                      PrimaryTextField(
                        hintText: "Required Loan Amount",
                        controller: loanAmountController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter loan amount" : null,
                      ),

                      const SizedBox(height: 10),

                      // Finalize Car Color (Dropdown)
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
                        value: carColor,
                        hint: const Text("Finalize Car Color"),
                        items: carColors
                            .map((color) => DropdownMenuItem(
                                  value: color,
                                  child: Text(color),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            carColor = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? "Please select a car color" : null,
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
