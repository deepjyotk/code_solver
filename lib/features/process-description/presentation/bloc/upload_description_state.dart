part of 'upload_description_bloc.dart';

@immutable
sealed class UploadDescriptionState {}

// final class UploadDescriptionInitial extends UploadDescriptionState {}
final class UploadDescriptionInitial extends UploadDescriptionState {}

class UploadDescriptionLoading extends UploadDescriptionState {}

class UploadDescriptionLoaded extends UploadDescriptionState {}

class UploadDescriptionError extends UploadDescriptionState {}
