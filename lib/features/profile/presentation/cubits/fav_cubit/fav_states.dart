import 'package:notenova/features/tips/domain/tips.dart';

class FavState{
  final List<Tip> favtips;

  FavState({required this.favtips});
}

class FavInitial extends FavState{
  FavInitial() : super(favtips: []);
}

class FavLoading extends FavState{
  FavLoading() : super(favtips: []);
}

class FavLoaded extends FavState{
  FavLoaded({required super.favtips});
}

class FavError extends FavState{
  final String message;

  FavError(this.message) : super(favtips: []);
}