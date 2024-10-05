import 'package:flutter/foundation.dart';
import 'package:rc_setting/model/access_token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isActivated = false;
  String? _username;
  late AccessTokenModel? _token;

  final String _cacheIsActivatedKey = '_isActivated';
  final String _cacheUsernameKey = '_username';
  final String _cacheTokenKey = '_token';

  Future<void> setIsActivate(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    notifyListeners();
  }

  Future<void> setUsername(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    notifyListeners();
  }

  Future<void> setToken(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
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

  void removeCahce() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheUsernameKey);
    prefs.remove(_cacheIsActivatedKey);
    prefs.remove(_cacheTokenKey);
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
    setIsActivate(_cacheIsActivatedKey, _isActivated);
    setUsername(_cacheUsernameKey, _username);
    setToken(_cacheTokenKey, _token?.token);
    notifyListeners();
  }

  void removeActivated() {
    _token = null;
    _isActivated = false;
    _username = null;
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
