import 'package:get/get.dart';

import '../modules/connect_device/bindings/connect_device_binding.dart';
import '../modules/connect_device/views/connect_device_view.dart';
import '../modules/detail_riwayat_kesehatan/bindings/detail_riwayat_kesehatan_binding.dart';
import '../modules/detail_riwayat_kesehatan/views/detail_riwayat_kesehatan_view.dart';
import '../modules/devices/bindings/device_binding.dart';
import '../modules/devices/views/device_view.dart';
import '../modules/hasil_pengukuran/bindings/hasil_pengukuran_binding.dart';
import '../modules/hasil_pengukuran/views/hasil_pengukuran_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kirim_ulasan/bindings/kirim_ulasan_binding.dart';
import '../modules/kirim_ulasan/views/kirim_ulasan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/riwayat_kesehatan/bindings/riwayat_kesehatan_binding.dart';
import '../modules/riwayat_kesehatan/views/riwayat_kesehatan_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DEVICE,
      page: () => const DeviceView(),
      binding: DeviceBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_KESEHATAN,
      page: () => const RiwayatKesehatanView(),
      binding: RiwayatKesehatanBinding(),
    ),
    GetPage(
      name: _Paths.CONNECT_DEVICE,
      page: () => const ConnectDeviceView(),
      binding: ConnectDeviceBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HASIL_PENGUKURAN,
      page: () => const HasilPengukuranView(),
      binding: HasilPengukuranBinding(),
    ),
    GetPage(
      name: _Paths.KIRIM_ULASAN,
      page: () => const KirimUlasanView(),
      binding: KirimUlasanBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RIWAYAT_KESEHATAN,
      page: () => const DetailRiwayatKesehatanView(),
      binding: DetailRiwayatKesehatanBinding(),
    ),
  ];
}
