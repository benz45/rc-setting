import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:rc_setting/model/access_token_model.dart';
import 'package:rc_setting/util/date_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isActivated = false;
  String? _username;
  AccessTokenModel? _token;
  String? _expiryDate;

  final String _cacheIsActivatedKey = '_isActivated';
  final String _cacheUsernameKey = '_username';
  final String _cacheTokenKey = '_token';
  final String _cacheExpiryDateKey = '_expiryDate';

  Future<void> setCacheBool(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      prefs.remove(key);
    } else {
      prefs.setBool(key, value);
    }
    notifyListeners();
  }

  Future<void> setCacheString(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      prefs.remove(key);
    } else {
      prefs.setString(key, value);
    }
    notifyListeners();
  }

  Future<bool?> getCahceIsActivate(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<String?> getCahceUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final res = prefs.getString(_cacheUsernameKey);
    return res;
  }

  Future<String?> getCahceToken() async {
    final prefs = await SharedPreferences.getInstance();
    final res = prefs.getString(_cacheTokenKey);
    return res;
  }

  Future<int?> getExpiryDate() async {
    final prefs = await SharedPreferences.getInstance();
    final res = prefs.getString(_cacheExpiryDateKey);
    if (res == null) return null;
    DateTime? date = DateFormat('dd-MM-yyyy').parse(res);
    return ExpiryChecker.daysUntilExpiry(date);
  }

  void removeCahce() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheUsernameKey);
    prefs.remove(_cacheIsActivatedKey);
    prefs.remove(_cacheTokenKey);
    prefs.remove(_cacheExpiryDateKey);
  }

  bool get isActivated {
    getCahceIsActivate(_cacheIsActivatedKey).then((e) => {
          if (e != null) {_isActivated = e}
        });
    return _isActivated;
  }

  void setActivated(AccessTokenModel value) {
    _token = value;
    _isActivated = value.used;
    _username = value.username!;
    setCacheBool(_cacheIsActivatedKey, _isActivated);
    setCacheString(_cacheUsernameKey, _username);
    setCacheString(_cacheTokenKey, _token?.token);
    setCacheString(_cacheExpiryDateKey, _token?.expiryDate);
    notifyListeners();
  }

  void removeActivated() {
    _token = null;
    _isActivated = false;
    _username = null;
    _expiryDate = null;
    removeCahce();
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<bool>('isActivated', _isActivated));
    properties.add(ObjectFlagProperty<String>('username', _username));
    properties.add(ObjectFlagProperty<AccessTokenModel>('token', _token));
  }
}
