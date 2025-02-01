import 'package:api_task/Data/Models/login_model.dart';
import 'package:api_task/Data/Models/network_response.dart';
import 'package:api_task/Data/Services/network_caller.dart';
import 'package:api_task/Data/Utils/Urls.dart';
import 'package:api_task/UI/Controllers/auth_controller.dart';
import 'package:api_task/UI/Screen/profile_screen.dart';
import 'package:api_task/UI/Widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: !inProgress,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: onTapSendButton,
                        child: const Text(
                          'Send',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapSendButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    signInSystem();
  }

  void signInSystem() async {
    inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": emailController.text,
      "password": passwordController.text
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.singInUrl, requestBody);

    inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      print('MyResponseData : ${response.responseData}');
      LoginModel loginModel =  LoginModel.fromJson(response.responseData);
      // print('MyUserModel : ${loginModel.data?.accessToken}');
      await AuthController.saveAccessToken(loginModel.data!.accessToken.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
          (_) => false);
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
