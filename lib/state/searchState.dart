import 'package:firebase_database/firebase_database.dart';
import 'package:rebeal/helper/enum.dart';
import 'package:rebeal/helper/utility.dart';
import 'package:rebeal/model/user.dart';
import 'appState.dart';

class SearchState extends AppStates {
  bool isBusy = false;
  SortUser sortBy = SortUser.MaxFollower;
  List<UserModel>? _userFilterlist;
  List<UserModel>? _userlist;

  List<UserModel>? get userlist {
    if (_userFilterlist == null) {
      return null;
    } else {
      return List.from(_userFilterlist!);
    }
  }

  void getDataFromDatabase() {
    try {
      isBusy = true;
      kDatabase.child('profile').once().then(
        (DatabaseEvent event) {
          final snapshot = event.snapshot;
          _userlist = <UserModel>[];
          _userFilterlist = <UserModel>[];
          if (snapshot.value != null) {
            var map = snapshot.value as Map?;
            if (map != null) {
              map.forEach((key, value) {
                var model = UserModel.fromJson(value);
                model.key = key;
                _userlist!.add(model);
                _userFilterlist!.add(model);
              });
              _userFilterlist!;
              notifyListeners();
            }
          } else {
            _userlist = null;
          }
          isBusy = false;
        },
      );
    } catch (error) {
      isBusy = false;
      print(error);
    }
  }

  void filterByUsername(String? name) {
    if (name != null &&
        name.isEmpty &&
        _userlist != null &&
        _userlist!.length != _userFilterlist!.length) {
      _userFilterlist = List.from(_userlist!);
    }
    if (_userlist == null && _userlist!.isEmpty) {
      print("User list is empty");
      return;
    }
    else if (name != null) {
      _userFilterlist = _userlist!
          .where((x) =>
              x.userName != null &&
              x.userName!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  String get selectedFilter {
    switch (sortBy) {
      case SortUser.Alphabetically:
        _userFilterlist!
            .sort((x, y) => x.displayName!.compareTo(y.displayName!));
        return "Alphabetically";

      case SortUser.MaxFollower:
        _userFilterlist!;
        return "Popular";

      case SortUser.Newest:
        _userFilterlist!.sort((x, y) =>
            DateTime.parse(y.createAt!).compareTo(DateTime.parse(x.createAt!)));
        return "Newest user";

      case SortUser.Oldest:
        _userFilterlist!.sort((x, y) =>
            DateTime.parse(x.createAt!).compareTo(DateTime.parse(y.createAt!)));
        return "Oldest user";

      case SortUser.Verified:
        _userFilterlist!;
        return "Verified user";

      default:
        return "Unknown";
    }
  }

  List<UserModel> userList = [];
  List<UserModel> getuserDetail(List<String> userIds) {
    final list = _userlist!.where((x) {
      if (userIds.contains(x.key)) {
        return true;
      } else {
        return false;
      }
    }).toList();
    return list;
  }
}
