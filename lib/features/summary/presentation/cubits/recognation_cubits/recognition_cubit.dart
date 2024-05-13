import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:notenova/features/summary/presentation/cubits/recognation_cubits/recognition_state.dart';

class TextRecognitionCubit extends Cubit<TextRecognitionState> {
  final picker = ImagePicker();

  TextRecognitionCubit() : super(TextRecognitionInitial());

  Future<void> getImageAndRecognize(ImageSource source) async {
    emit(TextRecognitionLoading());
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final response = await http.post(
        Uri.parse(
            'https://vision.googleapis.com/v1/images:annotate?key=AIzaSyCNd_FNH6jcjRUvV-8Qxd-V6ugXdWiy5sA'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'requests': [
            {
              'image': {'content': base64Encode(imageBytes)},
              'features': [
                {'type': 'TEXT_DETECTION'}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final textAnnotations =
            responseData['responses']?[0]?['textAnnotations'];

        if (textAnnotations != null && textAnnotations.isNotEmpty) {
          final detectedText = textAnnotations[0]['description'];
          emit(TextRecognitionLoaded(detectedText, File(pickedFile.path)));
        } else {
          emit(TextRecognitionLoaded('Text not found', null));
        }
      } else {
        emit(TextRecognitionError());
        print('Request failed with status: ${response.statusCode}');
      }
    }
  }
}
