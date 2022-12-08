import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities/logic/event/form_event.dart';
import 'package:universities/logic/repository/form/form_submit.dart';
import 'package:universities/logic/state/form_state.dart';

class FormBloc extends Bloc<FormEvent, FormsState> {
  FormBloc() : super(const FormSubmittedState()) {
    on<FormSubmissionEvent>(
        (event, emit) => _onFormSubmissionEvent(event, emit));
  }

  _onFormSubmissionEvent(
      FormSubmissionEvent event, Emitter<FormsState> emit) async {
    emit(const FormSubmittingState());
    try {
      await FormSubmitRepo.submit(
          event.email, event.name, event.age, event.image);
      emit(const FormSubmittedState());
    } catch (e) {
      emit( FormSubmitError(message: e.toString()));
    }
  }
}
