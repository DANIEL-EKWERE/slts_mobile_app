import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:slts_mobile_app/helpers/i_text_recognizer.dart';

class MLKitTextRecognizer extends ITextRecognizer {
  late TextRecognizer recognizer;

  MLKitTextRecognizer() {
    recognizer = TextRecognizer();
  }

  void dispose() {
    recognizer.close();
  }

  @override
  Future<String> processImage(String imgPath) async {
    final image = InputImage.fromFile(File(imgPath));
    // recognized = recognized.
    final  recognized = await recognizer.processImage(image);
    // recognized.blocks[1].text;
    // return recognized.blocks[1].text;
    return recognized.text;
  }
}