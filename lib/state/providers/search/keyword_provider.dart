import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeywordNotifier extends StateNotifier<String> {
  KeywordNotifier(String keyword) : super(keyword);

  void updateKeyword(String keyword) {
    state = keyword;
  }
}

final keywordProvider =
    StateNotifierProvider<KeywordNotifier, String>((ref) {
  return KeywordNotifier('');
});
