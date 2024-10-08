import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AdminLoginForm extends StatefulWidget {
  const AdminLoginForm({super.key});

  @override
  State<AdminLoginForm> createState() => _AdminLoginFormState();
}

class _AdminLoginFormState extends State<AdminLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormComponents.buildNormalTextField(
            _emailController,
            Text(
              'email'.tr,
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPasswordField(
            _passwordController,
            Text(
              'password'.tr,
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required'.tr;
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          MainButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<AuthenticationCubit>().loginAdmin(
                    _emailController.text, _passwordController.text);
              }
            },
            child: Text(
              'login'.tr,
              style: appTheme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
