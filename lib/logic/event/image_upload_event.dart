import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ImageUploadEvent extends Equatable {
  const ImageUploadEvent();
}

@immutable
class UploadImage extends ImageUploadEvent {
  @override
  List<Object?> get props => [];
}

