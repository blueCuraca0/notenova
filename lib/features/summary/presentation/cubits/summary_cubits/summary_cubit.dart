//import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/summary/data/services/firebase_services.dart';
import 'package:notenova/features/summary/domain/entities/summary.dart';
import 'package:notenova/features/summary/presentation/cubits/summary_cubits/summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  final SummaryFirestoreService _summaryService;

  SummaryCubit(this._summaryService) : super(SummaryLoading());

  Future<void> loadSummary() async {
    emit(SummaryLoading());
    try {
      final summaries = await _summaryService.getSummary().first;

      emit(SummaryLoaded(summaries));
    } catch (e) {
      emit(SummaryError('Failed to load summaries: $e'));
    }
  }

  Future<void> addSummary(Summary summary) async {
    try {
      emit(SummaryLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      await _summaryService.addSummary(summary);
      emit(SummaryLoading());
      loadSummary();
    } catch (e) {
      emit(SummaryError('Failed to add summary: $e'));
    }
  }

  Future<void> updateSummary(Summary summary) async {
    try {
      emit(SummaryLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      await _summaryService.updateSummary(summary);
      emit(SummaryLoading());
      loadSummary();
    } catch (e) {
      emit(SummaryError('Failed to update summary: $e'));
    }
  }

  void deleteSummary(Summary summary) async {
    try {
      await _summaryService.deleteSummary(summary);
    } catch (e) {
      emit(SummaryError('Failed to delete summary: $e'));
    }
  }
}
