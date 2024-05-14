import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeMode { light, dark }

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(lightTheme));

  void toggleTheme() {
    emit(state is LightThemeState ? ThemeState(darkTheme) : ThemeState(lightTheme));
  }
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(lightTheme);
}

class DarkThemeState extends ThemeState {
  DarkThemeState() : super(darkTheme);
}

final lightTheme = ThemeData(
  //primarySwatch: Colors.purple,
  appBarTheme: AppBarTheme(
    //color: Colors.purple,
    centerTitle: true,
    //elevation: 20,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  //primarySwatch: Colors.purple,
  appBarTheme: AppBarTheme(
    //color: Colors.purple,
    centerTitle: true,
    elevation: 20,
  ),
);
