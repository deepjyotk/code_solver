import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition_flutter/components/image_widget.dart';
import 'package:text_recognition_flutter/core/models/recognition_response.dart';
import 'package:text_recognition_flutter/core/recognizer/interface/text_recognizer.dart';
import 'package:text_recognition_flutter/core/recognizer/mlkit_text_recognizer.dart';
import 'package:text_recognition_flutter/core/recognizer/tesseract_text_recognizer.dart';
import 'package:text_recognition_flutter/features/process-description/presentation/bloc/upload_description_bloc.dart';

import '../../../../core/styles/button-styles.dart';
import '../../../../injection_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;

  RecognitionResponse? _response;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();

    /// Can be [MLKitTextRecognizer] or [TesseractTextRecognizer]
    _recognizer = MLKitTextRecognizer();
    // _recognizer = TesseractTextRecognizer();
  }

  /// m

  @override
  void dispose() {
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
  }

//! This is removed,
  // void processImage(String imgPath) async {
  //   final recognizedText = await _recognizer.processImage(imgPath);
  //   setState(() {
  //     _response = RecognitionResponse(
  //       imgPath: imgPath,
  //       recognizedText: recognizedText,
  //     );
  //   });
  // }

  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Text Recognition'),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         showDialog(
  //           context: context,
  //           builder: (context) => imagePickAlert(
  //             onCameraPressed: () async {
  //               final imgPath = await obtainImage(ImageSource.camera);
  //               if (imgPath == null) return;
  //               Navigator.of(context).pop();
  //               processImage(imgPath);
  //             },
  //             onGalleryPressed: () async {
  //               final imgPath = await obtainImage(ImageSource.gallery);
  //               if (imgPath == null) return;
  //               Navigator.of(context).pop();
  //               processImage(imgPath);
  //             },
  //           ),
  //         );
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //     body: _response == null
  //         ? const Center(
  //             child: Text('Pick image to continue'),
  //           )
  //         : ListView(
  //             children: [
  //               SizedBox(
  //                 height: MediaQuery.of(context).size.width,
  //                 width: MediaQuery.of(context).size.width,
  //                 child: Image.file(File(_response!.imgPath)),
  //               ),
  //               Padding(
  //                   padding: const EdgeInsets.all(16),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         // textBaseline: TextBaseline.ideographic,
  //                         // crossAxisAlignment: CrossAxisAlignment.baseline,
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         // crossAxisAlignment: CrossAxisAlignment.stretch,
  //                         children: [
  //                           Expanded(
  //                             child: Text(
  //                               "Recognized Text",
  //                               style: Theme.of(context).textTheme.titleLarge,
  //                             ),
  //                           ),
  //                           IconButton(
  //                             onPressed: () {
  //                               Clipboard.setData(
  //                                 ClipboardData(
  //                                     text: _response!.recognizedText),
  //                               );
  //                               ScaffoldMessenger.of(context).showSnackBar(
  //                                 const SnackBar(
  //                                   content: Text('Copied to Clipboard'),
  //                                 ),
  //                               );
  //                             },
  //                             icon: const Icon(Icons.copy),
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(height: 10),
  //                       Text(_response!.recognizedText),
  //                       const SizedBox(height: 10),
  //                       ElevatedButton(
  //                         onPressed: () {},
  //                         style: raisedButtonStyle,
  //                         child: const Text("Generate Code"),
  //                       ),
  //                     ],
  //                   )),
  //             ],
  //           ),
  //   );
  // }
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<UploadDescriptionBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UploadDescriptionBloc>(),
      child: BlocConsumer<UploadDescriptionBloc, UploadDescriptionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Upload Images for Problem Description'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => imagePickAlert(
                    onCameraPressed: () async {
                      final imgPath = await obtainImage(ImageSource.camera);
                      if (imgPath == null) return;
                      if (!mounted) return;

                      Navigator.of(context).pop();
                      BlocProvider.of<UploadDescriptionBloc>(context)
                          .add(SelectDescriptionImagesEvent(imgPath));
                    },
                    onGalleryPressed: () async {
                      final imgPath = await obtainImage(ImageSource.gallery);
                      if (imgPath == null) return;
                      if (!mounted) return;

                      Navigator.of(context).pop();
                      BlocProvider.of<UploadDescriptionBloc>(context)
                          .add(SelectDescriptionImagesEvent(imgPath));
                    },
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
            body: BlocBuilder<UploadDescriptionBloc, UploadDescriptionState>(
              builder: (context, state) {
                if (state is UploadDescriptionLoaded) {
                  return ListView(
                    children: [],
                  );
                } else {
                  return const Center(
                    child: Text('Pick image to continue'),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
