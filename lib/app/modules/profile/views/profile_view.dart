import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wish/app/resources/components/app_bar_component.dart';
import 'package:wish/app/resources/components/input_field_with_icon_component.dart';
import 'package:wish/app/resources/components/button_component.dart';
import 'package:wish/app/resources/components/dropdown_input_with_icon_component.dart';
import 'package:wish/app/resources/components/my_loader_screen_component.dart';
import 'package:wish/app/resources/utils/app_utils.dart';
import 'package:wish/app/services/login_services.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKeyProfile = GlobalKey<FormState>();
  final loginService = LoginService();
  final profileVM = Get.put(ProfileController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    profileVM.errors.clear();
    await profileVM.getUserProfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarComponent(
          title: "Profile",
          automaticallyImplyLeading: false,
          logoutButton: true,
        ),
        body: Obx(
          () => profileVM.isLoading.value == true
              ? const MyLoaderScreen()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKeyProfile,
                          child: Column(
                            children: [
                              InputFieldWithIconComponent(
                                readOnlyStatus: true,
                                errorText: profileVM.errors.isEmpty
                                    ? null
                                    : profileVM.errors['email'],
                                width: double.infinity,
                                controller: profileVM.emailController.value,
                                focusNode: profileVM.emailFocusedNode.value,
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
                                      profileVM.emailFocusedNode.value,
                                      profileVM.passwordFocusedNode.value);
                                },
                                hintText: "Email",
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                isPasswordField: false,
                              ),
                              InputFieldWithIconComponent(
                                width: double.infinity,
                                controller: profileVM.nameController.value,
                                focusNode: profileVM.nameFocusedNode.value,
                                errorText: profileVM.errors.isEmpty
                                    ? null
                                    : profileVM.errors['name'],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Nama tidak boleh kosong!";
                                  }
                                  return null;
                                },
                                onFiledSubmitted: (value) {
                                  AppUtils.fieldFocusChange(
                                      context,
                                      profileVM.nameFocusedNode.value,
                                      profileVM.emailFocusedNode.value);
                                },
                                hintText: "Nama",
                                icon: Icons.person,
                                inputType: TextInputType.text,
                                isPasswordField: false,
                              ),
                              InputFieldWithIconComponent(
                                width: double.infinity,
                                controller: profileVM.passwordController.value,
                                focusNode: profileVM.passwordFocusedNode.value,
                                errorText: profileVM.errors.isEmpty
                                    ? null
                                    : profileVM.errors['password'],
                                validator: (value) {
                                  return null;
                                },
                                onFiledSubmitted: (value) {
                                  AppUtils.fieldFocusChange(
                                      context,
                                      profileVM.passwordFocusedNode.value,
                                      profileVM.telpFocusedNode.value);
                                },
                                hintText: "Password",
                                icon: Icons.security,
                                inputType: TextInputType.emailAddress,
                                isPasswordField: true,
                              ),
                              InputFieldWithIconComponent(
                                width: double.infinity,
                                controller: profileVM.telpController.value,
                                focusNode: profileVM.telpFocusedNode.value,
                                errorText: profileVM.errors.isEmpty
                                    ? null
                                    : profileVM.errors['phone'],
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
                                      profileVM.telpFocusedNode.value,
                                      profileVM.genderFocusedNode.value);
                                },
                                hintText: "No.telp",
                                icon: Icons.person,
                                inputType: TextInputType.phone,
                                isPasswordField: false,
                              ),
                              DropdownInputWithIcon(
                                listValue: const ['Laki-laki', 'Perempuan'],
                                controller: profileVM.genderController.value,
                                focusNode: profileVM.genderFocusedNode.value,
                                errorText: profileVM.errors.isEmpty
                                    ? null
                                    : profileVM.errors['gender'],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Gender tidak boleh kosong!";
                                  }
                                  return null;
                                },
                                hintText: "Gender",
                                icon: Icons.person,
                                changeValue: (newValue) {
                                  profileVM.genderController.value =
                                      newValue.toString();
                                },
                              ),
                              InputFieldWithIconComponent(
                                width: double.infinity,
                                controller:
                                    profileVM.tanggalLahirController.value,
                                focusNode:
                                    profileVM.tanggalLahirFocusedNode.value,
                                errorText: profileVM.errors.isEmpty
                                    ? null
                                    : profileVM.errors['birthday'],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Tanggal lahir tidak boleh kosong!";
                                  }
                                  return null;
                                },
                                onFiledSubmitted: (value) {
                                  AppUtils.fieldFocusChange(
                                      context,
                                      profileVM.tanggalLahirFocusedNode.value,
                                      profileVM.tinggiFocusedNode.value);
                                },
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context),
                                          child: Container(child: child),
                                        );
                                      },
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      locale: const Locale('id'),
                                      context: context,
                                      initialDate:
                                          DateTime.now(), //get today's date
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    profileVM.tanggalLahirController.value
                                        .text = formattedDate;
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
                                  controller: profileVM.tinggiController.value,
                                  focusNode: profileVM.tinggiFocusedNode.value,
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
                              ButtonComponent(
                                  isLoading: profileVM.isLoading.value,
                                  icon: Icons.save,
                                  text: "Simpan Perubahan",
                                  onPress: () async {
                                    if (profileVM.isLoading.value == false) {
                                      // mengecek apakah input data sudah divalidasi lewat front end
                                      // mengecek apakah ada error dari api backend
                                      // jika salah satu terpenuhi maka dapat lanjut
                                      if (_formKeyProfile.currentState!
                                              .validate() ||
                                          profileVM.errors.isNotEmpty) {
                                        await profileVM.updateProfile(context);
                                      }
                                    }
                                    return;
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
