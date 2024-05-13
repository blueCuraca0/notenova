import 'package:notenova/features/tips/domain/tips.dart';

class TipState {
  final List<Tip> tips;
  final bool isLoading = false;

  TipState({required this.tips});
}

class TipInitial extends TipState {
  TipInitial() : super(tips: []);
}

class TipLoading extends TipState {
  TipLoading() : super(tips: []);
}

class TipLoaded extends TipState {
  TipLoaded({required super.tips});
}

class TipError extends TipState {
  final String message;

  TipError(this.message) : super(tips: []);
}
