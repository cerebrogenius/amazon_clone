import 'package:amazon_clone/utils/constants.dart';
import 'package:flutter/widgets.dart';

class TextFieldProvider extends ChangeNotifier {
  int addLength = largeAds.length;
  int currentAdd = 0;
  getNextAdd(int currentAdd) {
    if (currentAdd == addLength) {
      currentAdd = 1;
    }
    currentAdd++;
    print(currentAdd);
    notifyListeners();
    print(currentAdd);
  }

  int currentPage = 0;

  setCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  bool isLoading = false;
  bool getIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
    return isLoading;
  }
}
