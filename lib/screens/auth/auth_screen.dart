import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/screens/auth/login.dart';
import 'package:restaurants_sys/utilities/cubits/auth_cubit.dart';
import '../../utilities/cubits/states/auth_state.dart';
import '../home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Authentication')),
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.isAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.isAuthenticated && state.user != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Logged In as ${state.user!.name}'),
                    Text('Email: ${state.user!.email}'),
                    Text('Role: ${state.user!.role}'),
                    ElevatedButton(
                      onPressed: () async =>
                          {await context.read<AuthCubit>().logout()},
                      child: const Text('Logout'),
                    ),
                  ],
                );
              } else {
                return const LoginScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
