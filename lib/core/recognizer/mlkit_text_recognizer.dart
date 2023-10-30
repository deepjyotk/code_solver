import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../error/failures.dart';
import 'interface/text_recognizer.dart';

class MLKitTextRecognizer extends ITextRecognizer {
  late TextRecognizer recognizer;

//! fix the dependency injection of this later.
  MLKitTextRecognizer() {
    recognizer = TextRecognizer();
  }

  void dispose() {
    recognizer.close();
  }

  @override
  Future<Either<Failure, String>> processImage(String imgPath) async {
    try {
      final image = InputImage.fromFile(File(imgPath));
      final recognized = await recognizer.processImage(image);
      return Right(recognized.text);
    } catch (error) {
      return Left(SomethingWenWrongFailure());
    }
  }

  Future<void> processImageInBlocks(InputImage image) async {
    final recognized = await recognizer.processImage(image);
    final blocks = recognized.blocks;
    for (int i = 0; i < blocks.length; i++) {
      final e = blocks[i];
      log("Block number $i");
      log(e.text);
    }
  }
}
