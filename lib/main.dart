import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'first_name',
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'last_name',
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                FormBuilderDateTimePicker(
                  name: 'dob',
                  inputType: InputType.date,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'phone',
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.minLength(10),
                  ]),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'address',
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(
                      6,
                      errorText: 'Password must be at least 6 characters',
                    ),
                  ]),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _formKey.currentState!.value;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfirmationPage(
                            firstName: formData['first_name'],
                            lastName: formData['last_name'],
                          ),
                        ),
                      );
                    } else {
                      debugPrint("Validation failed");
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final String firstName;
  final String lastName;

  const ConfirmationPage({super.key, required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirmation")),
      body: Center(
        child: Text(
          "Welcome, $firstName $lastName!\nSignup Successful",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
