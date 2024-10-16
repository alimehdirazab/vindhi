import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = "profileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _employeeIdController;
  late TextEditingController _designationController;
  late TextEditingController _gradeController;
  late TextEditingController _zoneController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _addressController;
  late TextEditingController _joiningDateController;
  bool _isAvailable = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with dummy data
    _nameController = TextEditingController(text: 'John Doe');
    _employeeIdController = TextEditingController(text: '12345');
    _designationController = TextEditingController(text: 'Software Engineer');
    _gradeController = TextEditingController(text: 'A1');
    _zoneController = TextEditingController(text: 'West');
    _emailController = TextEditingController(text: 'johndoe@example.com');
    _phoneController = TextEditingController(text: '9876543210');
    _stateController = TextEditingController(text: 'California');
    _cityController = TextEditingController(text: 'San Francisco');
    _addressController = TextEditingController(text: '1234 Elm Street');
    _joiningDateController = TextEditingController(text: '2020-01-01');
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);
        // Here you would normally call a function to upload the image
        // For now, we'll just simulate an upload with a snackbar message
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image selected: ${image.path}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
    }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_nameController, 'Name'),
                _buildTextField(_employeeIdController, 'Employee ID'),
                _buildTextField(_designationController, 'Designation'),
                _buildTextField(_gradeController, 'Grade'),
                _buildTextField(_zoneController, 'Zone'),
                _buildTextField(_emailController, 'Email'),
                _buildTextField(_phoneController, 'Phone'),
                _buildTextField(_stateController, 'State'),
                _buildTextField(_cityController, 'City'),
                _buildTextField(_addressController, 'Address'),
                _buildTextField(_joiningDateController, 'Joining Date'),
                SwitchListTile(
                  title: const Text('Are you Available'),
                  value: _isAvailable,
                  onChanged: (newValue) {
                    setState(() {
                      _isAvailable = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Here you would normally save the updated data
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage:
                      AssetImage('assets/first_loans_app_icon.png'),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55.0, left: 55.0),
                    child: IconButton(
                      icon:
                          const Icon(Icons.camera_alt, color: Colors.blueGrey),
                      onPressed: _pickAndUploadImage,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildProfileTile("Name", _nameController.text),
                  const Divider(),
                  _buildProfileTile("Employee ID", _employeeIdController.text),
                  const Divider(),
                  _buildProfileTile("Designation", _designationController.text),
                  const Divider(),
                  _buildProfileTile("Grade", _gradeController.text),
                  const Divider(),
                  _buildProfileTile("Zone", _zoneController.text),
                  const Divider(),
                  _buildProfileTile("Email", _emailController.text),
                  const Divider(),
                  _buildProfileTile("Phone", _phoneController.text),
                  const Divider(),
                  _buildProfileTile("State", _stateController.text),
                  const Divider(),
                  _buildProfileTile("City", _cityController.text),
                  const Divider(),
                  _buildProfileTile("Address", _addressController.text),
                  const Divider(),
                  _buildProfileTile(
                      "Joining Date", _joiningDateController.text),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _showEditDialog,
                child: const Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: const TextStyle(color: Colors.grey)),
    );
  }
}
