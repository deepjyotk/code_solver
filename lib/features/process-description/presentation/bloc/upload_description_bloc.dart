import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_recognition_flutter/core/recognizer/interface/text_recognizer.dart';

part 'upload_description_event.dart';
part 'upload_description_state.dart';

class UploadDescriptionBloc
    extends Bloc<UploadDescriptionEvent, UploadDescriptionState> {
  final ITextRecognizer recognizer;
  UploadDescriptionBloc({required this.recognizer})
      : super(UploadDescriptionInitial()) {
    on<SelectDescriptionImagesEvent>(onSelectImageEvent);
    // on<>(onLoadedTemp);
  }

  Stream<UploadDescriptionState> onSelectImageEvent(
      SelectDescriptionImagesEvent event,
      Emitter<UploadDescriptionState> emit) async* {
    final recognizedText = await recognizer.processImage(event.imagePath);

    yield* recognizedText.fold((failure) async* {
      yield UploadDescriptionError();
    }, (message) async* {
      yield UploadDescriptionLoaded();
    });

    // setState(() {
    //   _response = RecognitionResponse(
    //     imgPath: imgPath,
    //     recognizedText: recognizedText,
    //   );
    // });
  }
}
