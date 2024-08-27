import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/features/auth/presentation/view/register_view.dart';
import 'package:untitled4/features/auth/presentation/view/widgets/custom_text_form_field.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/app_styles/app_styles.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../manager/auth_provider/auth_provider.dart';

class LoginView extends StatelessWidget {
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static final formKey = GlobalKey<FormState>();

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Image.asset(
                  AppAssets.logo,
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Login',
                style: AppStyles.style25,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Login to continue using the app',
                style: AppStyles.style18Grey,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Username',
                style: AppStyles.style20,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                title: 'Enter your user name',
                controller: userNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your user name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Password',
                style: AppStyles.style20,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                title: 'Enter password',
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your password';
                  }
                  return null;
                },
                isPassword: true,
                isSuffixIconShown: true,
              ),
              const SizedBox(
                height: 7,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forget Password ? ',
                    style: TextStyle(color: Color(0xff6e6f72)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<AuthProvider>(
                builder: (BuildContext context, AuthProvider authProvider,
                    Widget? child) {
                  if (authProvider.isLoginLoading == true) {
                    return const CustomCircularProgressIndicator();
                  }
                  return CustomButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        authProvider.userLogin(
                        context: context,
                        userData: {
                          'username': userNameController.text.trim(),
                          'password': passwordController.text.trim(),
                        },
                      );
                        userNameController.text = '';
                        passwordController.text = '';
                      }
                    },
                    title: 'Login',
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    " Don't have an account? ",
                  ),
                  CustomTextButton(
                    title: 'Register',
                    fontSize: 17,
                    onPressed: () {
                      navigate(
                        context: context,
                        screen: const RegisterView(),
                      );
                    },
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    )));
  }
}
