import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnonClientSignupForm extends StatefulWidget {
  const AnonClientSignupForm({super.key});

  @override
  State<AnonClientSignupForm> createState() => _AnonClientSignupFormState();
}

class _AnonClientSignupFormState extends State<AnonClientSignupForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _emergencyContactController =
      TextEditingController();

  String selectedCountryCode = '+251';
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emergencyContactController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomFormComponents.buildNormalTextField(
                  _usernameController,
                  Text(
                    'Username',
                    style: appTheme.textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CustomFormComponents.buildNormalTextField(
                  _emailController,
                  Text(
                    'Email',
                    style: appTheme.textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPasswordField(
            _passwordController,
            Text(
              'Password',
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPasswordField(
            _confirmPasswordController,
            Text(
              'Confirm Password',
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }

              if (value != _passwordController.text.trim()) {
                return 'Passwords do not match';
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPhoneNumberField(
            _emergencyContactController,
            Text(
              'Emergency Contact',
              style: appTheme.textTheme.bodyMedium,
            ),
            selectedCountryCode,
            ['+1', '+2', '+251', '+19', '+23'],
            (String? newValue) {
              setState(() {
                selectedCountryCode = newValue ?? '+251';
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your emergency contact number';
              }

              return null;
            },
          ),
          const SizedBox(height: 25),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return MainButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<AuthenticationCubit>().registreClientAnonymously(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        emergencyContact:
                            '$selectedCountryCode${_emergencyContactController.text}',
                        isAnonymous: true);
                  }
                },
                child: state is Authenticating
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Sign Up',
                        style: appTheme.textTheme.titleMedium,
                      ),
              );
            },
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: appTheme.textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/clientLogin');
                },
                child: Text(
                  'Login',
                  style: appTheme.textTheme.labelMedium,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}