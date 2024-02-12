import 'package:ecommerce/core/components/custom_button.dart';
import 'package:ecommerce/core/components/custom_text_form_field.dart';
import 'package:ecommerce/features/login/view/manager/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final userNameController = TextEditingController(text: "mor_2314");
  final passwordController = TextEditingController(text: "83r5^_");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<LoginProvider>(context).isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Container()),
                  const Text(
                    'Create an account',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Let’s create your account',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Username",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                      hintText: 'Enter your username',
                      controller: userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      }),
                  const SizedBox(height: 24),
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    hintText: 'Enter your password',
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  SizedBox(height: 24),
                  CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Provider.of<LoginProvider>(context, listen: false)
                              .loginUser(context,
                                  username: userNameController.text,
                                  password: passwordController.text);
                        }
                      },
                      label: 'Login'),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  )
                ]),
          ),
        )),
      ),
    );
  }
}
