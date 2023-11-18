import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SecureStorageService {
  final storage = const FlutterSecureStorage();

  Future<String> getDataUser() async {
    String? user = await storage.read(key: "token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(user.toString());
    return decodedToken.toString();
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> setToken(data) async {
    await storage.write(key: "token", value: data);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: "token");
  }
}
