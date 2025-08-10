import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:third_practice/counter_cubit.dart';
import 'package:third_practice/counter_state.dart';
import 'package:third_practice/Theme_Cubit.dart';
import 'package:third_practice/theme_state.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' counter'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              final themeCubit = context.read<ThemeCubit>();
              final isDark = state is ThemeDark;

              return Switch(
                value: isDark,
                onChanged: (newValue) {
                  themeCubit.changeTheme(newValue);
                },
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                final currentState = state as CounterInitial;
                return NewWidget(currentState: currentState);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({super.key, required this.currentState});

  final CounterInitial currentState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Color.fromARGB(255, 151, 101, 115),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${currentState.count}', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: context.read<CounterCubit>().decrement,
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: context.read<CounterCubit>().increment,
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: context.read<CounterCubit>().reset,
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
