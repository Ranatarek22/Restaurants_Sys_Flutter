import 'package:bloc/bloc.dart';
import 'package:restaurants_sys/utilities/cubits/states/auth_state.dart';
import 'package:restaurants_sys/utilities/services/auth_service.dart';

import '../secure_storage.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthState(isAuthenticated: false));

  Future<void> login({required Map<String, dynamic> credentials}) async {
    await _authService.loginUser(credentials);
    // Suppose the token and user details are obtained after registration
    String token = await SecureStorage.getItem('auth_token') ?? '';
    final user = await _authService.getActiveUser(token);

    emit(AuthState(isAuthenticated: true, token: token, user: user));
  }

  Future<void> register({required Map<String, dynamic> userData}) async {
    // Simulate a registration process
    // print('object');
    await _authService.createUser(userData);
    // print('object');
    // await Future.delayed(Duration(seconds: 2));
    // Suppose the token and user details are obtained after registration
    String token = await SecureStorage.getItem('auth_token') ?? '';
    final user = await _authService.getActiveUser(token);
    emit(AuthState(isAuthenticated: true, token: token, user: user));
  }

  Future<void> logout() async {
    await SecureStorage.removeItem('auth_token');

    emit(AuthState(isAuthenticated: false));
  }
}
