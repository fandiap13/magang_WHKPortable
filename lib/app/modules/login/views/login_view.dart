import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/input_field_with_icon_component.dart';
import 'package:wish/app/resources/components/button_component.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:wish/app/services/login_services.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginVM = Get.put(LoginController());
  final _formKeyLogin = GlobalKey<FormState>();
  final loginService = LoginService();

  @override
  void initState() {
    super.initState();
    loginService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 35,
                    color: AppColors.lightDark,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  "WHK Portable",
                  // overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKeyLogin,
                    child: Column(
                      children: [
                        InputFieldWithIconComponent(
                          width: double.infinity,
                          controller: loginVM.emailController.value,
                          focusNode: loginVM.emailFocusedNode.value,
                          validator: (value) {
                            if (value.trim()!.isEmpty) {
                              return "Email tidak boleh kosong!";
                            }
                            if (!isEmail(value)) {
                              return "Email tidak valid!";
                            }
 
                            return null;
                          },
                          onFiledSubmitted: (value) {
                            AppUtils.fieldFocusChange(
                                context,
                                loginVM.emailFocusedNode.value,
                                loginVM.passwordFocusedNode.value);
                          },
                          hintText: "Email",
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          isPasswordField: false,
                        ),
                        InputFieldWithIconComponent(
                          width: double.infinity,
                          controller: loginVM.passwordController.value,
                          focusNode: loginVM.passwordFocusedNode.value,
                          validator: (value) {
                            if (value.trim()!.isEmpty) {
                              return "Password tidak boleh kosong!";
                            }
                            return null;
                          },
                          onFiledSubmitted: (value) {},
                          hintText: "Password",
                          icon: Icons.security,
                          inputType: TextInputType.emailAddress,
                          isPasswordField: true,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Obx(
                          () => ButtonComponent(
                              isLoading: loginVM.isLoading.value,
                              icon: Icons.login,
                              text: "Login",
                              onPress: () async {
                                if (loginVM.isLoading.value == false) {
                                  if (_formKeyLogin.currentState!.validate()) {
                                    await loginVM.login(context);
                                  }
                                }
                                return;
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum punya akun ?",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.secondaryColor,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero)),
                                onPressed: () {
                                  Get.toNamed(Routes.REGISTER);
                                },
                                child: Text(
                                  "Register",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                      fontSize: 18.0),
                                ))
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
