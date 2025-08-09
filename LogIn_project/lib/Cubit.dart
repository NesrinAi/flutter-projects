import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/core/shared_prefs_helper.dart';
import 'package:flutter_application_2/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<BaseClass> {
  LoginCubit() : super(InitialState());

  Future<void> login(String email, String password) async {
    emit(LoadState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await SharedPrefsHelper().setString("user_email", email);
      emit(SuccessState('login successed'));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}
