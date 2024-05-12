abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Map<String, dynamic> userData;

  UserLoaded(this.userData);
}

class UserError extends UserState {
  final String errorMessage;

  UserError(this.errorMessage);
}
