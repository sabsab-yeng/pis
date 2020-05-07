
import 'dart:async';

import 'package:pis/ui/screens/drawer/example/user_data_helper.dart';
import 'package:pis/ui/screens/drawer/example/user_model.dart';

abstract class HomeContract {
  void screenUpdate();
}

class HomePresenter {
  HomeContract _view;
  var db = DatabaseHelper();
  HomePresenter(this._view);
  delete(User user) {
    var db = DatabaseHelper();
    db.deleteUsers(user);
    updateScreen();
  }

  Future<List<User>> getUser() {
    return db.getUser();
  }

  updateScreen() {
    _view.screenUpdate();

  }
}