import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_state.dart';
class CounterCubit extends Cubit<CounterState> {
  final SharedPreferences prefs;
  final String _key = 'counter_value';
  CounterCubit(this.prefs) : super(CounterInitial(0)){
    _loadValue();
  }

  void increment() {
    final currentState = state as CounterInitial;
    final newValue = currentState.count + 1;
     prefs.setInt(_key, newValue);
    emit(CounterInitial(newValue));
  }

  void decrement() {
    final currentState = state as CounterInitial;
    final newValue = currentState.count - 1;
    prefs.setInt(_key, newValue);
    emit(CounterInitial(newValue));
  }
  void reset(){
    prefs.setInt(_key, 0);
    emit(CounterInitial(0));
  }
  
  void _loadValue() {
    final savedValue = prefs.getInt(_key)??0;
    emit(CounterInitial(savedValue));
  }
}