abstract class DarkState {
  bool darkTheme ;

  DarkState({required this.darkTheme});
}

class DarkInitial extends DarkState {
  DarkInitial() : super(darkTheme: false);
}

class DarkChange extends DarkState {
  DarkChange({required darkTheme}): super(darkTheme: darkTheme);
}