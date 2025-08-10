import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCounterCubit extends Cubit<int> {
  SimpleCounterCubit() : super(0);

  void increment() => emit(state + 1);
  void reset() => emit(0);
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SimpleCounterCubit(),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocBuilder<SimpleCounterCubit, int>(
                builder: (context, count) {
                  return Text(
                    '$count',
                    style: const TextStyle(fontSize: 30),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<SimpleCounterCubit>().increment(),
                    child: const Text('Add'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<SimpleCounterCubit>().reset(),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
