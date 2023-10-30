import 'package:dartz/dartz.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:text_recognition_flutter/core/error/failures.dart';
import 'interface/text_recognizer.dart';

class TesseractTextRecognizer extends ITextRecognizer {
  @override
  Future<Either<Failure, String>> processImage(String imgPath) {
    // TODO: implement processImage
    throw UnimplementedError();
  }
  // @override
  // Future<String> processImage(String imgPath) async {
  //   final res = await FlutterTesseractOcr.extractText(imgPath, args: {
  //     "psm": "4",
  //     "preserve_interword_spaces": "1",
  //   });
  //   print("----- Res");
  //   print(res);
  //   return res;
  // }
}
