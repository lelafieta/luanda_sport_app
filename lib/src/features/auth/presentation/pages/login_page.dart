import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:luanda_sport_app/src/features/auth/domain/entities/login_entity.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/gradient_button_widget.dart';
import '../cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          print(state);
          EasyLoading.dismiss();
          if (state is AuthLoading) {
            EasyLoading.show(status: "Loading");
          } else if (state is AuthError) {
            EasyLoading.showError(state.message);
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.luandaSport,
            );
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // AppColors.primary,
                // AppColors.primary,
                // Color(0xFF6A11CB),
                AppColors.lightWightColor,
                AppColors.lightWightColor
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Entra para continuar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    FormBuilderTextField(
                      name: "email",
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Colors.white,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Campo obrigatório"),
                        FormBuilderValidators.email(
                            errorText: "E-mail inválido")
                      ]),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: "password",
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Colors.white,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Campo obrigatório"),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    GradientButton(
                      text: "Login",
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          context.read<AuthCubit>().login(LoginEntity(
                              email:
                                  formKey.currentState?.fields["email"]!.value,
                              password: formKey
                                  .currentState?.fields["password"]!.value));
                        }
                      },
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (formKey.currentState?.validate() == true) {
                    //       context.read<AuthCubit>().login(LoginEntity(
                    //           email:
                    //               formKey.currentState?.fields["email"]!.value,
                    //           password: formKey
                    //               .currentState?.fields["password"]!.value));
                    //     }
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(vertical: 16),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     backgroundColor: Colors.black,
                    //   ),
                    //   child: const Text(
                    //     'Login',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Esqueceu a password?',
                        style: TextStyle(
                          color: Colors.white70,
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
}
