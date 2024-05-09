import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/summary/data/firebase_services.dart';
import 'package:notenova/features/summary/domain/entities/summary_model.dart';
import 'package:notenova/features/summary/presentation/cubits/summary_cubits/summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  final SummaryFirestoreService _summaryService;

  SummaryCubit(this._summaryService) : super(SummaryLoading());

  Future<void> loadSummary() async {
     emit(SummaryLoading());
    try {
      final summaries = await _summaryService.getSummary().first;
       print('summary');
      print(summaries.length);
      emit(SummaryLoaded(summaries));
    } catch (e) {
      emit(SummaryError('Failed to load summaries: $e'));
    }
  }

  Future<void> addSummary(Summary summary) async {
    try {
      await _summaryService.addSummary(summary);
      loadSummary();
    } catch (e) {
      emit(SummaryError('Failed to add summary: $e'));
    }
  }

  Future<void> updateSummary(Summary summary) async {
    try {
      await _summaryService.updateSummary(summary);
      loadSummary();
    } catch (e) {
      emit(SummaryError('Failed to update summary: $e'));
    }
  }

  void deleteSummary(Summary summary) async {
    try {
      await _summaryService.deleteSummary(summary);
      loadSummary();
    } catch (e) {
      emit(SummaryError('Failed to delete summary: $e'));
    }
  }
}
