import 'package:notenova/features/summary/domain/entities/summary_model.dart';

abstract class SummaryState {}

class SummaryLoading extends SummaryState {}

class SummaryLoaded extends SummaryState {
  final List<Summary> summaries;

  SummaryLoaded(this.summaries);
}

class SummaryError extends SummaryState {
  final String errorMessage;

  SummaryError(this.errorMessage);
}
