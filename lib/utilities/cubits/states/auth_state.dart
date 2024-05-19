import '/models/user_model.dart';

class AuthState {
  final bool isAuthenticated;
  final String? token;
  final UserModel? user;

  AuthState({
    required this.isAuthenticated,
    this.token,
    this.user,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    UserModel? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}
