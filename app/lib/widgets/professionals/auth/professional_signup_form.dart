import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalSignupForm extends StatefulWidget {
  const ProfessionalSignupForm({super.key});

  @override
  State<ProfessionalSignupForm> createState() => _ProfessionalSignupFormState();
}

class _ProfessionalSignupFormState extends State<ProfessionalSignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _pricePerHourController = TextEditingController();

  String selectedCountryCode = '+251';

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    _nationalityController.dispose();
    _addressController.dispose();
    _professionController.dispose();
    _experienceController.dispose();
    _languageController.dispose();
    _pricePerHourController.dispose();
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
                  _nameController,
                  Text(
                    'Name',
                    style: appTheme.textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Your name is required';
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
            _phoneNumberController,
            Text(
              'Phone',
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
          const SizedBox(height: 15),
          CustomFormComponents.buildDatePickerField(
              context,
              _dateOfBirthController,
              Text(
                'Birth Date',
                style: appTheme.textTheme.bodyMedium,
              ), validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your Birth date';
            }

            return null;
          }),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomFormComponents.buildDropdownInputField(
                  Text(
                    'Address',
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  ['Addis Ababa', 'Adama', 'Bahrdar', 'Dire Dawa'],
                  'Addis Ababa',
                  (String? newValue) {
                    setState(() {
                      _addressController.text = newValue ?? 'Addis Ababa';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your address';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: CustomFormComponents.buildDropdownInputField(
                  Text(
                    'Nationality',
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  ['Ethiopia', 'USA', 'Kenya', 'Sudan', 'Germany'],
                  "Ethiopia",
                  (String? newValue) {
                    setState(() {
                      _nationalityController.text = newValue ?? "";
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your residency';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildDropdownInputField(
            Text(
              'Profession',
              style: appTheme.textTheme.bodyMedium,
            ),
            [
              "Psychiatrists",
              "Clinical Psychologists",
              "Counseling Psychologists",
              "Licensed Clinical Social Workers (LCSWs)",
              "Marriage and Family Therapists (MFTs)",
              "Licensed Professional Counselors (LPCs)",
              "Psychiatric Nurses",
              "School Psychologists",
              "Substance Abuse Counselors",
              "Mental Health Counselors",
              "Art Therapists,Occupational Therapists (OTs)",
              "other"
            ],
            "Psychiatrists",
            (String? newValue) {
              setState(() {
                _professionController.text = newValue ?? "";
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your Profession';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildDropdownInputField(
            Text(
              'Years of exprience',
              style: appTheme.textTheme.bodyMedium,
            ),
            ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
            "0",
            (String? newValue) {
              setState(() {
                _experienceController.text = newValue ?? "";
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your Expreience';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomFormComponents.buildDropdownInputField(
                    Text(
                      'Language',
                      style: appTheme.textTheme.bodyMedium,
                    ),
                    ['English', 'Amharic'],
                    'English', (String? newValue) {
                  setState(() {
                    _languageController.text = newValue ?? 'English';
                  });
                }, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select Language';
                  }

                  return null;
                }),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: CustomFormComponents.buildNormalTextField(
                    _pricePerHourController,
                    Text(
                      'Price',
                      style: appTheme.textTheme.bodyMedium,
                    ), validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }

                  return null;
                }),
              )
            ],
          ),
          const SizedBox(height: 15),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return MainButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<AuthenticationCubit>().registerProfessional(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        phoneNumber:
                            '$selectedCountryCode${_phoneNumberController.text}',
                        dateOfBirth:
                            DateTime.parse(_dateOfBirthController.text),
                        nationality: _nationalityController.text,
                        address: _addressController.text,
                        profession: _professionController.text,
                        experience: int.parse(_experienceController.text),
                        languageToProvideService: _languageController.text,
                        pricePerHour:
                            double.parse(_pricePerHourController.text));
                    // Form is valid, proceed with further processing
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
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
                  Navigator.pushReplacementNamed(context, '/professionalLogin');
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