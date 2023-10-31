import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/input_field_with_icon_component.dart';
import 'package:wish/app/resources/components/button_component.dart';
import 'package:wish/app/resources/components/dropdown_input_with_icon_component.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:wish/app/services/login_services.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final registerVM = Get.put(RegisterController());
  final _formKeyRegister = GlobalKey<FormState>();
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
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Registrasi",
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
              Obx(
                () => Form(
                    key: _formKeyRegister,
                    child: Column(
                      children: [
                        InputFieldWithIconComponent(
                          width: double.infinity,
                          controller: registerVM.nameController.value,
                          focusNode: registerVM.nameFocusedNode.value,
                          errorText: registerVM.errors.isEmpty
                              ? null
                              : registerVM.errors['name'],
                          validator: (value) {
                            if (value.trim()!.isEmpty) {
                              return "Nama tidak boleh kosong!";
                            }
                            return null;
                          },
                          onFiledSubmitted: (value) {
                            AppUtils.fieldFocusChange(
                                context,
                                registerVM.nameFocusedNode.value,
                                registerVM.emailFocusedNode.value);
                          },
                          hintText: "Nama",
                          icon: Icons.person,
                          inputType: TextInputType.text,
                          isPasswordField: false,
                        ),
                        InputFieldWithIconComponent(
                          errorText: registerVM.errors.isEmpty
                              ? null
                              : registerVM.errors['email'],
                          width: double.infinity,
                          controller: registerVM.emailController.value,
                          focusNode: registerVM.emailFocusedNode.value,
                          validator: (value) {
                            if (value!.isEmpty) {
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
                                registerVM.emailFocusedNode.value,
                                registerVM.passwordFocusedNode.value);
                          },
                          hintText: "Email",
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          isPasswordField: false,
                        ),
                        InputFieldWithIconComponent(
                          width: double.infinity,
                          controller: registerVM.passwordController.value,
                          focusNode: registerVM.passwordFocusedNode.value,
                          errorText: registerVM.errors.isEmpty
                              ? null
                              : registerVM.errors['password'],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password tidak boleh kosong!";
                            }
                            return null;
                          },
                          onFiledSubmitted: (value) {
                            AppUtils.fieldFocusChange(
                                context,
                                registerVM.passwordFocusedNode.value,
                                registerVM.telpFocusedNode.value);
                          },
                          hintText: "Password",
                          icon: Icons.security,
                          inputType: TextInputType.emailAddress,
                          isPasswordField: true,
                        ),
                        InputFieldWithIconComponent(
                          width: double.infinity,
                          controller: registerVM.telpController.value,
                          focusNode: registerVM.telpFocusedNode.value,
                          errorText: registerVM.errors.isEmpty
                              ? null
                              : registerVM.errors['phone'],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "No.telp tidak boleh kosong!";
                            }
                            if (!isLength(value, 11)) {
                              return "No.Telp minimal 11 Karakter!";
                            }
                            return null;
                          },
                          onFiledSubmitted: (value) {
                            AppUtils.fieldFocusChange(
                                context,
                                registerVM.telpFocusedNode.value,
                                registerVM.genderFocusedNode.value);
                          },
                          hintText: "No.telp",
                          icon: Icons.person,
                          inputType: TextInputType.phone,
                          isPasswordField: false,
                        ),
                        DropdownInputWithIcon(
                          listValue: const ['Laki-laki', 'Perempuan'],
                          controller: registerVM.genderController.value,
                          focusNode: registerVM.genderFocusedNode.value,
                          errorText: registerVM.errors.isEmpty
                              ? null
                              : registerVM.errors['gender'],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Gender tidak boleh kosong!";
                            }
                            return null;
                          },
                          hintText: "Gender",
                          icon: Icons.person,
                          changeValue: (newValue) {
                            registerVM.genderController.value =
                                newValue.toString();
                          },
                        ),
                        InputFieldWithIconComponent(
                          width: double.infinity,
                          controller: registerVM.tanggalLahirController.value,
                          focusNode: registerVM.tanggalLahirFocusedNode.value,
                          errorText: registerVM.errors.isEmpty
                              ? null
                              : registerVM.errors['birthday'],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Tanggal lahir tidak boleh kosong!";
                            }
                            return null;
                          },
                          onFiledSubmitted: (value) {
                            AppUtils.fieldFocusChange(
                                context,
                                registerVM.tanggalLahirFocusedNode.value,
                                registerVM.tinggiFocusedNode.value);
                          },
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                locale: const Locale('id'),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              registerVM.tanggalLahirController.value.text =
                                  formattedDate;
                            }
                          },
                          hintText: "Tanggal Lahir",
                          icon: Icons.date_range,
                          isPasswordField: false,
                          readOnlyStatus: true,
                        ),
                        Obx(
                          () => InputFieldWithIconComponent(
                            width: double.infinity,
                            controller: registerVM.tinggiController.value,
                            focusNode: registerVM.tinggiFocusedNode.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Tinggi tidak boleh kosong!";
                              }
                              return null;
                            },
                            onFiledSubmitted: (value) {},
                            hintText: "Tinggi (cm)",
                            icon: Icons.person,
                            inputType: TextInputType.number,
                            isPasswordField: false,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Obx(
                          () => ButtonComponent(
                              isLoading: registerVM.isLoading.value,
                              icon: Icons.save,
                              text: "Register",
                              onPress: () async {
                                if (registerVM.isLoading.value == false) {
                                  // mengecek apakah input data sudah divalidasi lewat front end
                                  // mengecek apakah ada error dari api backend
                                  // jika salah satu terpenuhi maka dapat lanjut
                                  if (_formKeyRegister.currentState!
                                          .validate() ||
                                      registerVM.errors.isNotEmpty) {
                                    await registerVM.register(context);
                                    debugPrint(registerVM.errors.toString());
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
                              "Sudah punya akun ?",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.secondaryColor,
                                  fontSize: 18.0),
                            ),
                            TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero)),
                                onPressed: () {
                                  Get.toNamed(Routes.LOGIN);
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                      fontSize: 18.0),
                                ))
                          ],
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
