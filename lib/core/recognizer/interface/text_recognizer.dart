import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

abstract class ITextRecognizer {
  Future<Either<Failure, String>> processImage(String imgPath);
}
