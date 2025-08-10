import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences prefs;
  final String _key = 'theme';

  ThemeCubit(this.prefs) : super(ThemeInitial()) {
    _loadTheme();
  }

  void _loadTheme() {
    final isDark = prefs.getBool(_key);

    if (isDark == true) {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }

  void changeTheme(bool isDark) {
    prefs.setBool(_key, isDark);

    if (isDark) {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }
}
