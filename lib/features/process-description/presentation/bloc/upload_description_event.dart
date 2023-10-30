part of 'upload_description_bloc.dart';

@immutable
sealed class UploadDescriptionEvent extends Equatable {}

// final class LoadingEvent
// final class GetDescriptionImagesEvent extends UploadDescriptionEvent {}

final class SelectDescriptionImagesEvent extends UploadDescriptionEvent {
  final String imagePath;

  SelectDescriptionImagesEvent(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}
