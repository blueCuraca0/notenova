import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/tips/domain/tips.dart';
import 'package:notenova/features/profile/data/firebase_service_fav.dart';
import 'package:notenova/features/profile/presentation/cubits/fav_cubit/fav_states.dart';
import 'dart:async';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class FavCubit extends Cubit<FavState> {
  final FavTipsFirebaseService _favtipsService;

  FavCubit(this._favtipsService) : super(FavInitial());

  Future<void> loadFavs() async {
    emit(FavLoading());
    try {
      final favTips = await _favtipsService.getFavs().first;
      emit(FavLoaded(favtips: favTips));
    } catch (e) {
      emit(FavError(LocaleKeys.no_tips.tr()));
    }
  }

  void addFav(Tip tip) async {
    await _favtipsService.addFavTip(tip);
    loadFavs();
  }

  void deleteFav(Tip tip) async {
    await _favtipsService.deleteTip(tip);
    loadFavs();
  }

  bool inFavs(Tip tip) {
    for (var fav in state.favtips) {
      if (fav.title == tip.title) {
        return true;
      }
    }
    return false;
  }
}
