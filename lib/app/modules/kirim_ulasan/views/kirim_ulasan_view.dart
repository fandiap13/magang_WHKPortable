import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/button_component.dart';
import 'package:wish/app/routes/app_pages.dart';

import '../controllers/kirim_ulasan_controller.dart';

class KirimUlasanView extends StatefulWidget {
  const KirimUlasanView({Key? key}) : super(key: key);

  @override
  State<KirimUlasanView> createState() => _KirimUlasanViewState();
}

class _KirimUlasanViewState extends State<KirimUlasanView> {
  final kirimUlasanVM = Get.put(KirimUlasanController());
  final formKirimUlasan = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.lightDark,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          // statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: const Text('Kirim Ulasan'),
        centerTitle: true,
        backgroundColor: AppColors.lightDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: formKirimUlasan,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextFormField(
                      controller: kirimUlasanVM.pesanController.value,
                      focusNode: kirimUlasanVM.pesanFocusNode.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ulasan tidak boleh kosong !";
                        }
                        return null;
                      },
                      maxLines: 15,
                      decoration: InputDecoration(
                        label: const Text(
                          "Tulis Ulasan...",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        filled: true,
                        hintText: "Tulis Ulasan",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors
                                  .primaryColor), // Warna border saat focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors
                                  .transparent), // Warna border saat tidak focused
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ButtonComponent(
                      isLoading: false,
                      text: "Kirim Ulasan",
                      onPress: () {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text("Mantap")));

                        Get.toNamed(Routes.HOME);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonComponent(
                      isLoading: false,
                      bgColor: AppColors.dangerColor,
                      text: "Batal",
                      onPress: () {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text("Mantap")));

                        // Get.toNamed(Routes.HOME);
                      }),
                ],
              )),
        ),
      ),
    );
  }
}
