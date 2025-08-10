import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'counter_cubit.dart';
import 'counter_state.dart';
import 'home.dart';
import 'theme_state.dart';
import 'Theme_Cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit(prefs)), 
        BlocProvider(create: (_) => ThemeCubit(prefs)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDark = state is ThemeDark;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            home: const CounterScreen(),
          );
        },
      ),
    );
  }
}
