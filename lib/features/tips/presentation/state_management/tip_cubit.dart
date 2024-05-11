import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/tips/domain/tips.dart';
import 'package:notenova/features/tips/presentation/state_management/tip_states.dart';
import 'package:notenova/features/tips/data/firebase_tips.dart';

class TipCubit extends Cubit<TipState> {
  final FirebaseServiceTips _tipsService;

  TipCubit(this._tipsService) : super(TipInitial());

  List<Tip> get tips => state.tips;

  Future<void> loadTips() async {
    emit(TipLoading());
    try {
      final tips = await _tipsService.getTips().first;
      emit(TipLoaded(tips: tips));
    } catch (e) {
      emit(TipError('No tips today, sorry:(')); //TODO: hardcoded message
    }
  }
}