abstract class UploadFileState {}

class UploadingFileState extends UploadFileState {
  UploadingFileState();
}

class UploadedFileState extends UploadFileState {
  UploadedFileState();
}

class ErroredUploadFileState extends UploadFileState {
  final String error;

  ErroredUploadFileState(this.error);
}
