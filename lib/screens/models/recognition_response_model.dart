import 'package:slts_mobile_app/services/logger.dart';

class RecognitionResponse {
  Logger logger = Logger('RecognitionResponse');

  final String imgPath;
   String recognizedText;

  RecognitionResponse({
    required this.imgPath,
    required this.recognizedText,
  }) {
    logger.log("RecognitionResponse initialized: $imgPath, $recognizedText");
  }

  @override
  bool operator ==(covariant RecognitionResponse other) {
    if (identical(this, other)) return true;

    return other.imgPath == imgPath && other.recognizedText == recognizedText;
  }

  @override
  int get hashCode => imgPath.hashCode ^ recognizedText.hashCode;
}
