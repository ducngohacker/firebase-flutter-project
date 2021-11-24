abstract class StringValidator {
  bool isValid(String value);
}
class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    // TODO: implement isValid
    return value.isNotEmpty;
  }
}
class EmailAndPasswordValidator {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailTextError = 'Email can\'t be empty ';
  final String invalidPasswordTextError = 'Password can\'t be empty ';
}