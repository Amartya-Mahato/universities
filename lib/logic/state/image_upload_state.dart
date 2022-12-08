import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ImageUploadState extends Equatable {
  final Uint8List? image;
  const ImageUploadState({required this.image});
  @override
  List<Object?> get props => [image];
}

@immutable
class InitialImage extends ImageUploadState {
  const InitialImage() : super(image: null);
  @override
  List<Object?> get props => [image];
}

@immutable
class ImageUploaded extends ImageUploadState {
  const ImageUploaded({required Uint8List? image}) : super(image: image);
  @override
  List<Object?> get props => [image];
}

@immutable
class ImageUploading extends ImageUploadState {
  const ImageUploading({required Uint8List? image}) : super(image: image);
  @override
  List<Object?> get props => [image];
}
