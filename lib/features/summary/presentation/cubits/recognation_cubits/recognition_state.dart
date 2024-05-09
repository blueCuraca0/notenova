import 'dart:io';

abstract class TextRecognitionState {}

class TextRecognitionInitial extends TextRecognitionState {}

class TextRecognitionLoading extends TextRecognitionState {}

class TextRecognitionLoaded extends TextRecognitionState {
  final String detectedText;
  final File? selectedImage;

  TextRecognitionLoaded(this.detectedText, this.selectedImage);
}

class TextRecognitionError extends TextRecognitionState {}
