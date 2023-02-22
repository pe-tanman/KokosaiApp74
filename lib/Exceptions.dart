// ignore_for_file: file_names

class NotSignedInException {
  final String? msg;

  const NotSignedInException({this.msg = 'User not signed in!'});

  @override
  String toString() => 'NotSignedInException { message: $msg}';
}

class NotExistsUserDocException {
  final String? msg;

  const NotExistsUserDocException({this.msg = 'User document not exists!'});

  @override
  String toString() => 'NotExistsUserDocException { message: $msg}';
}
