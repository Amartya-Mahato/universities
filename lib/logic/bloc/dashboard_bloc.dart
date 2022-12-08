import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:universities/logic/event/dashboard_event.dart';
import 'package:universities/logic/repository/dashboard/dashboard_repo.dart';
import 'package:universities/logic/state/dashboard_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState>
    with HydratedMixin {
  DashBoardBloc() : super(const InitialDashBoard()) {
    on<InitializeDashBoard>(
        (event, emit) => _onInitializeDashBoard(event, emit));
  }

  _onInitializeDashBoard(
      InitializeDashBoard event, Emitter<DashBoardState> emit) async {
    emit(const DashBoardLoading());
    try {
      List<String> list = await DashBoardRepo.initialize();
      emit(DashBoardLoaded(list[2], list[0], list[1]));
    } catch (e) {
      emit(const DashBoardError());
    }
  }

  @override
  DashBoardState? fromJson(Map<String, dynamic> json) {
    return DashBoardState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(DashBoardState state) {
    return state.toMap();
  }
}
