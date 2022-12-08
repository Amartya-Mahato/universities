import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:universities/logic/event/university_api_event.dart';
import 'package:universities/logic/model/university_api_model.dart';
import 'package:universities/logic/repository/universityApi/university_api_repo.dart';
import 'package:universities/logic/state/university_api_state.dart';

class UniversityApiBloc extends Bloc<UniversityApiEvent, UniversityApiState>
    with HydratedMixin {
  UniversityApiBloc() : super(const UniversityApiInitialState()) {
    on<UniversityApiInitializeEvent>(
        (event, emit) => _onUniversityApiInitializeEvent(event, emit));
  }

  _onUniversityApiInitializeEvent(UniversityApiInitializeEvent event,
      Emitter<UniversityApiState> emit) async {
    try {
      emit(const UniversityApiInitialState());
      List<UniversityApiModel> universities =
          await UniversityApiRepo.loadUniversityApiModel();
      emit(UniversityApiLoadedState(universities: universities));
    } catch (e) {
      emit(UniversityApiErrorState());
      throw Exception(e);
    }
  }

  @override
  UniversityApiState? fromJson(Map<String, dynamic> json) {
    return UniversityApiState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UniversityApiState state) {
    return state.toMap();
  }
}
