import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities/logic/event/image_upload_event.dart';
import 'package:universities/logic/repository/upload/image_upload_repo.dart';
import 'package:universities/logic/state/image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  ImageUploadBloc() : super(const InitialImage()) {
    on<UploadImage>((event, emit) => _onUploadImage(event, emit));
  }

  _onUploadImage(UploadImage event, Emitter<ImageUploadState> emit) async {
    emit(ImageUploading(image: state.image));

    Uint8List? image = await ImageUploadRepo.uploadImage();
    if (image != null) {
      emit(ImageUploaded(image: image));
    } else {
      emit(ImageUploading(image: state.image));
    }
  }
}
