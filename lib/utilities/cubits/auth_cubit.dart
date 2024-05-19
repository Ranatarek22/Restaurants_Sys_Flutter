import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurants_sys/utilities/cubits/states/auth_state.dart';
import '../../models/user_model.dart';
import 'package:restaurants_sys/utilities/services/auth_service.dart';

import '../secure_storage.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthState(isAuthenticated: false));

  Future<void> login({required Map<String, dynamic> credentials}) async {
    // Simulate a registration process
    // print('object');
    await _authService.loginUser(credentials);
    // print('object');
    // await Future.delayed(Duration(seconds: 2));
    // Suppose the token and user details are obtained after registration
    String token = await SecureStorage.getItem('auth_token') ?? '';
    final user = await _authService.getActiveUser(token);

    emit(AuthState(isAuthenticated: true, token: token, user: user));
  }

  // Future<void> tryToken({String? token}) async {
  //   if (token == null) {
  //     throw "no token provided";
  //   }
  //
  //   // get active user api
  //   // ApiConfig.setToken(token);
  //   // Map<String, dynamic> data = await ApiConfig.get(
  //   //   '/active_user',
  //   // );
  //
  //   // print(data);
  //   final user = UserModel.fromJson(data);
  //   _isLoggedIn = true;
  //   _token = token;
  //
  //   try {
  //     // Save token securely
  //     await SecureStorage.setItem("auth_token", token);
  //   } catch (e) {
  //     // Request failed due to an error
  //     Fluttertoast.showToast(
  //       msg: '$e',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.redAccent,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   }
  // }

  Future<void> register({required Map<String, dynamic> userData}) async {
    // Simulate a registration process
    print('object');
    await _authService.createUser(userData);
    print('object');
    // await Future.delayed(Duration(seconds: 2));
    // Suppose the token and user details are obtained after registration
    String token = await SecureStorage.getItem('auth_token') ?? '';
    final user = await _authService.getActiveUser(token);
    emit(AuthState(isAuthenticated: true, token: token, user: user));
  }

  void logout() {
    emit(AuthState(isAuthenticated: false));
  }
}
