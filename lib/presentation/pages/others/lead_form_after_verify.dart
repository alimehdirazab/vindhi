import 'package:flutter/material.dart';

import 'package:vindhi_app/presentation/pages/home/home_page.dart';
import 'package:vindhi_app/presentation/widgets/primary_button.dart';
import 'package:vindhi_app/presentation/widgets/primary_textfield.dart';

class LeadFormAfterVerify extends StatefulWidget {
  const LeadFormAfterVerify({super.key});

  static const String routeName = "leadFormAfterVerify";

  @override
  State<LeadFormAfterVerify> createState() => _LeadFormAfterVerifyState();
}

class _LeadFormAfterVerifyState extends State<LeadFormAfterVerify> {
  final _formKey2 = GlobalKey<FormState>();
  // Controllers for OTP verification and address fields
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _buildingNameController = TextEditingController();
  final TextEditingController _areaSectorController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String? _addressType;

  // Function to handle form submission
  void _submitForm2() {
    if (_formKey2.currentState!.validate()) {
      // Process the form data here (e.g., send it to an API)
      Navigator.pushNamed(context, HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildAfterOtp(),
      ),
    );
  }

  Widget _buildAfterOtp() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey2,
        child: Column(
          children: [
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _addressType,
              decoration: const InputDecoration(
                hintText: 'Address Type',
              ),
              items: ['Rental', 'Permanent']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _addressType = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select address type' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'House Number',
              controller: _houseNumberController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter house number' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Apartment/Building Name',
              controller: _buildingNameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter building name' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Area/Sector',
              controller: _areaSectorController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter area/sector' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'Postal Code',
              controller: _postalCodeController,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter postal code' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'State',
              controller: _stateController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter state' : null,
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              hintText: 'City',
              controller: _cityController,
              validator: (value) => value!.isEmpty ? 'Please enter city' : null,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              onPressed: _submitForm2,
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
