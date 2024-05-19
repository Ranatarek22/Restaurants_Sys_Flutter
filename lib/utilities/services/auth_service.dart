import 'package:restaurants_sys/models/user_model.dart';
import '../helpers/api_config.dart';
import '../secure_storage.dart';

class AuthService {
  Future<UserModel> getActiveUser(String token) async {
    Map<String, dynamic> data = await ApiConfig().get(
      endpoint: 'api/auth/active_user',
      token: token,
    );

    // print(userData);
    // Save token securely
    await SecureStorage.setItem("auth_token", token);

    return UserModel.fromJson(data);
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    Map<String, dynamic> data = await ApiConfig().post(
      endpoint: 'api/auth/register',
      body: userData,
    );

    String? token = data['token'];

    // print(token);
    if (token != null && token.isNotEmpty) {
      // Save token securely
      await SecureStorage.setItem("auth_token", token);
    }
  }

  Future<void> loginUser(Map<String, dynamic> credentials) async {
    Map<String, dynamic> data = await ApiConfig().post(
      endpoint: 'api/auth/login',
      body: credentials,
    );

    String? token = data['token'];
    if (token != null && token.isNotEmpty) {
      // Save token securely
      await SecureStorage.setItem("auth_token", token);
    }
  }
}
