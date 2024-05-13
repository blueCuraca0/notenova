import 'package:flutter_bloc/flutter_bloc.dart';
import 'darkTheme_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkCubit extends Cubit<DarkState> {
  DarkCubit() : super(DarkInitial());

  void changeTheme() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('darkTheme', !state.darkTheme);
    });
    emit(DarkChange(darkTheme: !state.darkTheme));
  }

  bool getTheme() {
    SharedPreferences.getInstance().then((prefs) {
      emit(DarkChange(darkTheme: prefs.getBool('darkTheme') ?? false));
    });
    return state.darkTheme;
  }
}