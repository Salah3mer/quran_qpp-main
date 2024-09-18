class Func {
  static String removeTashkeel(String input) {
    return input.replaceAll(
        RegExp(r'([^\u0621-\u063A\u0641-\u064A\u0660-\u0669a-zA-Z0-9 ])'), '');
  }
}
