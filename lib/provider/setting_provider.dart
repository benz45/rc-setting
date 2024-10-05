import 'package:flutter/foundation.dart';
import 'package:rc_setting/config/option_config.dart';
import 'package:rc_setting/model/base_option_model.dart';
import 'package:rc_setting/model/screen_size_model.dart';
import 'package:rc_setting/model/setting_default_model.dart';
import 'package:rc_setting/model/setting_model.dart';

class SettingProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _profileSelected = 1;
  int _currentProfileUseged = 1;

  int get getProfileSelected => _profileSelected;
  int get getCurrentProfileUseged => _currentProfileUseged;

  bool _preventTaskbarOverlap = true;
  bool get getPreventTaskbarOverlap => _preventTaskbarOverlap;
  void setPreventTaskbarOverlap(bool value) {
    _preventTaskbarOverlap = value;
    notifyListeners();
  }

  ProfileConfig get getCurrentProfileConfig => ProfileConfig(
        preventTaskbarOverlap: _preventTaskbarOverlap,
        performance: _performance.value,
        screenMode: _screenMode.value,
        screenSize: ScreenSizeModel(
            width: _screenSize.width, height: _screenSize.height),
        screenFramerate: _screenFramerate.value,
        sightDistance: _sightDistance.value,
        carCountLevel: _carCountLevel.value,
        carTexLevel: _carTexLevel.value,
        carEffectLevel: _carEffectLevel.value,
        envmapLevel: _envmapLevel.value,
        fieldLevel: _fieldLevel.value,
        texDetailLevel: _texDetailLevel.value,
        lightTexDetailLevel: _lightTexDetailLevel.value,
        reflection: _reflection.value,
        sceneGlowOn: _sceneGlowOn.value,
        motionBlurOn: _motionBlurOn.value,
        multiSampleType: _multiSampleType.value,
        carLodLevel: _carLodLevel.value,
        renderSignboard: _renderSignboard.value,
        waterReflection: _waterReflection.value,
        bloomLevel: _bloomLevel.value,
        dynLight2: _dynLight2.value,
      );

  void setProfileUseged(int value) {
    _currentProfileUseged = value;
    notifyListeners();
  }

  void setProfile(int value) {
    _profileSelected = value;
    if (value == 1) {
      mapSettingConfigToState(_settingConfig.profile1);
    }
    if (value == 2) {
      mapSettingConfigToState(_settingConfig.profile2);
    }
    if (value == 3) {
      mapSettingConfigToState(_settingConfig.profile3);
    }
    notifyListeners();
  }

  void mapSettingConfigToState(ProfileConfig profileConfig) {
    _preventTaskbarOverlap = profileConfig.preventTaskbarOverlap;
    _screenMode = firstWhereBool(profileConfig.screenMode, _screenModeList);
    _performance = firstWhereInt(profileConfig.performance, _performanceList);
    _screenFramerate =
        firstWhereInt(profileConfig.screenFramerate, _screenFramerateList);
    _screenSize = screenSizeList.firstWhere(
        (e) =>
            e.width == profileConfig.screenSize.width &&
            e.height == profileConfig.screenSize.height,
        orElse: () => screenSizeList.first);
    _sightDistance =
        firstWhereInt(profileConfig.sightDistance, _sightDistanceList);
    _carCountLevel =
        firstWhereInt(profileConfig.carCountLevel, _carCountLevelList);
    _carTexLevel = firstWhereInt(profileConfig.carTexLevel, _carTexLevelList);
    _carEffectLevel =
        firstWhereInt(profileConfig.carEffectLevel, _carEffectLevelList);
    _envmapLevel = firstWhereInt(profileConfig.envmapLevel, _envmapLevelList);
    _fieldLevel = firstWhereInt(profileConfig.fieldLevel, _fieldLevelList);
    _texDetailLevel =
        firstWhereInt(profileConfig.texDetailLevel, _texDetailLevelList);
    _lightTexDetailLevel =
        firstWhereInt(profileConfig.texDetailLevel, _lightTexDetailLevelList);
    _reflection = firstWhereBool(profileConfig.reflection, _reflectionList);
    _sceneGlowOn = firstWhereBool(profileConfig.sceneGlowOn, _sceneGlowOnList);
    _motionBlurOn =
        firstWhereBool(profileConfig.motionBlurOn, _motionBlurOnList);
    _multiSampleType =
        firstWhereInt(profileConfig.multiSampleType, _multiSampleTypeList);
    _carLodLevel = firstWhereInt(profileConfig.carLodLevel, _carLodLevelList);
    _renderSignboard =
        firstWhereBool(profileConfig.renderSignboard, _renderSignboardList);
    _waterReflection =
        firstWhereBool(profileConfig.waterReflection, _waterReflectionList);
    _bloomLevel = firstWhereInt(profileConfig.bloomLevel, _bloomLevelList);
    _dynLight2 = firstWhereInt(profileConfig.dynLight2, _dynLight2List);
    notifyListeners();
  }

  void mapSettingDefaultToState(SettingDefaultModel profileConfig) {
    _sightDistance =
        firstWhereInt(profileConfig.sightDistance, _sightDistanceList);
    _carCountLevel =
        firstWhereInt(profileConfig.carCountLevel, _carCountLevelList);
    _carTexLevel = firstWhereInt(profileConfig.carTexLevel, _carTexLevelList);
    _carEffectLevel =
        firstWhereInt(profileConfig.carEffectLevel, _carEffectLevelList);
    _envmapLevel = firstWhereInt(profileConfig.envmapLevel, _envmapLevelList);
    _fieldLevel = firstWhereInt(profileConfig.fieldLevel, _fieldLevelList);
    _texDetailLevel =
        firstWhereInt(profileConfig.texDetailLevel, _texDetailLevelList);
    _lightTexDetailLevel =
        firstWhereInt(profileConfig.texDetailLevel, _lightTexDetailLevelList);
    _reflection = firstWhereBool(profileConfig.reflection, _reflectionList);
    _sceneGlowOn = firstWhereBool(profileConfig.sceneGlowOn, _sceneGlowOnList);
    _motionBlurOn =
        firstWhereBool(profileConfig.motionBlurOn, _motionBlurOnList);
    _multiSampleType =
        firstWhereInt(profileConfig.multiSampleType, _multiSampleTypeList);
    _carLodLevel = firstWhereInt(profileConfig.carLodLevel, _carLodLevelList);
    _renderSignboard =
        firstWhereBool(profileConfig.renderSignboard, _renderSignboardList);
    _waterReflection =
        firstWhereBool(profileConfig.waterReflection, _waterReflectionList);
    _bloomLevel = firstWhereInt(profileConfig.bloomLevel, _bloomLevelList);
    _dynLight2 = firstWhereInt(profileConfig.dynLight2, _dynLight2List);
    notifyListeners();
  }

  late ConfigModel _settingConfig;
  ConfigModel get getSettingConfig => _settingConfig;

  void setSettingConfig(ConfigModel? value) {
    if (value != null) {
      _settingConfig = value;
      _profileSelected = value.currentProfile;
      _currentProfileUseged = value.currentProfile;
      late ProfileConfig profileConfig;
      if (value.currentProfile == 1) {
        profileConfig = value.profile1;
      }
      if (value.currentProfile == 2) {
        profileConfig = value.profile2;
      }
      if (value.currentProfile == 3) {
        profileConfig = value.profile3;
      }

      mapSettingConfigToState(profileConfig);
      notifyListeners();
    }
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _screenFramerateList = screenFramerateList;
  late BaseOpntionModel<int> _screenFramerate = screenFramerateList.first;

  List<BaseOpntionModel<int>> get getScreenFramerateList =>
      _screenFramerateList;
  BaseOpntionModel<int> get getScreenFramerate => _screenFramerate;

  void setScreenFramerate(BaseOpntionModel<int> value) {
    _screenFramerate = value;
    notifyListeners();
  }

  // -----------------------------------------------------------------------
  final List<BaseOpntionModel<bool>> _screenModeList = screenModeList;
  late BaseOpntionModel<bool> _screenMode = screenModeList.first;

  List<BaseOpntionModel<bool>> get getScreenModeList => _screenModeList;
  BaseOpntionModel<bool> get getScreenMode => _screenMode;

  void setScreenMode(BaseOpntionModel<bool> value) {
    _screenMode = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _performanceList = performanceList;
  late BaseOpntionModel<int> _performance = performanceList[1];
  BaseOpntionModel<int> get performance => _performance;
  List<BaseOpntionModel<int>> get getPerformanceList => _performanceList;

  void setPerformance(BaseOpntionModel<int> value) {
    _performance = value;
    notifyListeners();
  }

  void changePerformance(BaseOpntionModel<int> value) {
    _performance = value;
    late SettingDefaultModel settingDefaultModel;
    if (value.value == 0) {
      settingDefaultModel = defaultUltra;
    } else if (value.value == 1 || value.value == 5) {
      settingDefaultModel = defaultHeight;
    } else if (value.value == 2) {
      settingDefaultModel = defaultMiddle;
    } else if (value.value == 3) {
      settingDefaultModel = defaultLow;
    }
    mapSettingDefaultToState(settingDefaultModel);
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<ScreenSizeModel> _screenSizeList = screenSizeList;
  late ScreenSizeModel _screenSize = screenSizeList.first;

  ScreenSizeModel get getScreenSize => _screenSize;
  List<ScreenSizeModel> get getScreenSizeList => _screenSizeList;

  void setScreenSize(int widht, int height) {
    _screenSize = _screenSizeList.firstWhere(
        (option) => option.width == widht && option.height == height,
        orElse: () => _screenSizeList.first);
    notifyListeners();
  }

  void addScreenSize(int widht, int height) {
    _screenSizeList.add(ScreenSizeModel(width: widht, height: height));
    _screenSizeList.sort((a, b) => b.width.compareTo(a.width));
    notifyListeners();
  }

  void addScreenSizeModel(ScreenSizeModel? value) {
    if (value != null && value?.width != null && value?.height != null) {
      if (!_screenSizeList.any((e) => e.width == value.width && e.height == value.height)) {
        _screenSizeList
            .add(ScreenSizeModel(width: value.width, height: value.height));
        _screenSizeList.sort((a, b) => b.width.compareTo(a.width));
        notifyListeners();
      }
    }
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _sightDistanceList = sightDistanceList;
  late BaseOpntionModel<int> _sightDistance = sightDistanceList.first;
  BaseOpntionModel<int> get sightDistance => _sightDistance;
  List<BaseOpntionModel<int>> get getSightDistanceList => _sightDistanceList;

  void setSightDistance(BaseOpntionModel<int> value) {
    _sightDistance = value;
    notifyListeners();
  }

  // -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _carCountLevelList = carCountLevelList;
  late BaseOpntionModel<int> _carCountLevel = carCountLevelList.first;
  BaseOpntionModel<int> get getCarCountLevel => _carCountLevel;
  List<BaseOpntionModel<int>> get getCarCountLevelList => _carCountLevelList;

  void setCarCountLevel(BaseOpntionModel<int> value) {
    _carCountLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _carTexLevelList = carTexLevelList;
  late BaseOpntionModel<int> _carTexLevel = carTexLevelList.first;
  BaseOpntionModel<int> get getCarTexLevel => _carTexLevel;
  List<BaseOpntionModel<int>> get getCarTexLevelList => _carTexLevelList;

  void setCarTexLevel(BaseOpntionModel<int> value) {
    _carTexLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _carEffectLevelList = carEffectLevelList;
  late BaseOpntionModel<int> _carEffectLevel = carEffectLevelList.first;
  BaseOpntionModel<int> get getCarEffectLevel => _carEffectLevel;
  List<BaseOpntionModel<int>> get getCarEffectLevelList => _carEffectLevelList;

  void setCarEffectLevel(BaseOpntionModel<int> value) {
    _carEffectLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _envmapLevelList = envmapLevelList;
  late BaseOpntionModel<int> _envmapLevel = envmapLevelList.first;
  BaseOpntionModel<int> get getEnvmapLevel => _envmapLevel;
  List<BaseOpntionModel<int>> get getEnvmapLevelList => _envmapLevelList;

  void setEnvmapLevel(BaseOpntionModel<int> value) {
    _envmapLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _fieldLevelList = fieldLevelList;
  late BaseOpntionModel<int> _fieldLevel = fieldLevelList.first;
  BaseOpntionModel<int> get getFieldLevel => _fieldLevel;
  List<BaseOpntionModel<int>> get getFieldLevelList => _fieldLevelList;

  void setFieldLevel(BaseOpntionModel<int> value) {
    _fieldLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _texDetailLevelList = texDetailLevelList;
  late BaseOpntionModel<int> _texDetailLevel = texDetailLevelList.first;
  BaseOpntionModel<int> get getTexDetailLevel => _texDetailLevel;
  List<BaseOpntionModel<int>> get getTexDetailLevelList => _texDetailLevelList;

  void setTexDetailLevel(BaseOpntionModel<int> value) {
    _texDetailLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _lightTexDetailLevelList =
      lightTexDetailLevelList;
  late BaseOpntionModel<int> _lightTexDetailLevel =
      lightTexDetailLevelList.first;
  BaseOpntionModel<int> get getLightTexDetailLevel => _lightTexDetailLevel;
  List<BaseOpntionModel<int>> get getLightTexDetailLevelList =>
      _lightTexDetailLevelList;

  void setLightTexDetailLevel(BaseOpntionModel<int> value) {
    _lightTexDetailLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<bool>> _reflectionList = reflectionList;
  late BaseOpntionModel<bool> _reflection = reflectionList.first;
  BaseOpntionModel<bool> get getReflection => _reflection;
  List<BaseOpntionModel<bool>> get getReflectionList => _reflectionList;

  void setReflection(BaseOpntionModel<bool> value) {
    _reflection = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<bool>> _sceneGlowOnList = sceneGlowOnList;
  late BaseOpntionModel<bool> _sceneGlowOn = sceneGlowOnList.first;
  BaseOpntionModel<bool> get getSceneGlowOn => _sceneGlowOn;
  List<BaseOpntionModel<bool>> get getSceneGlowOnList => _sceneGlowOnList;

  void setSceneGlowOn(BaseOpntionModel<bool> value) {
    _sceneGlowOn = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<bool>> _motionBlurOnList = motionBlurOnList;
  late BaseOpntionModel<bool> _motionBlurOn = motionBlurOnList.first;
  BaseOpntionModel<bool> get getMotionBlurOn => _motionBlurOn;
  List<BaseOpntionModel<bool>> get getMotionBlurOnList => _motionBlurOnList;

  void setMotionBlurOn(BaseOpntionModel<bool> value) {
    _motionBlurOn = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _multiSampleTypeList = multiSampleTypeList;
  late BaseOpntionModel<int> _multiSampleType = multiSampleTypeList.first;
  BaseOpntionModel<int> get getMultiSampleType => _multiSampleType;
  List<BaseOpntionModel<int>> get getMultiSampleTypeList =>
      _multiSampleTypeList;

  void setMultiSampleType(BaseOpntionModel<int> value) {
    _multiSampleType = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _carLodLevelList = carLodLevelList;
  late BaseOpntionModel<int> _carLodLevel = carLodLevelList.first;
  BaseOpntionModel<int> get getCarLodLevel => _carLodLevel;
  List<BaseOpntionModel<int>> get getCarLodLevelList => _carLodLevelList;

  void setCarLodLevel(BaseOpntionModel<int> value) {
    _carLodLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<bool>> _renderSignboardList = renderSignboardList;
  late BaseOpntionModel<bool> _renderSignboard = renderSignboardList.first;
  BaseOpntionModel<bool> get getRenderSignboard => _renderSignboard;
  List<BaseOpntionModel<bool>> get getRenderSignboardList =>
      _renderSignboardList;

  void setRenderSignboard(BaseOpntionModel<bool> value) {
    _renderSignboard = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<bool>> _waterReflectionList = waterReflectionList;
  late BaseOpntionModel<bool> _waterReflection = waterReflectionList.first;
  BaseOpntionModel<bool> get getWaterReflection => _waterReflection;
  List<BaseOpntionModel<bool>> get getWaterReflectionList =>
      _waterReflectionList;

  void setWaterReflection(BaseOpntionModel<bool> value) {
    _waterReflection = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _bloomLevelList = bloomLevelList;
  late BaseOpntionModel<int> _bloomLevel = bloomLevelList.first;
  BaseOpntionModel<int> get getBloomLevel => _bloomLevel;
  List<BaseOpntionModel<int>> get getBloomLevelList => _bloomLevelList;

  void setBloomLevel(BaseOpntionModel<int> value) {
    _bloomLevel = value;
    notifyListeners();
  }

// -----------------------------------------------------------------------
  final List<BaseOpntionModel<int>> _dynLight2List = dynLight2List;
  late BaseOpntionModel<int> _dynLight2 = dynLight2List.first;
  BaseOpntionModel<int> get getDynLight2 => _dynLight2;
  List<BaseOpntionModel<int>> get getDynLight2List => _dynLight2List;

  void setDynLight2(BaseOpntionModel<int> value) {
    _dynLight2 = value;
    notifyListeners();
  }

  // -----------------------------------------------------------------------

  BaseOpntionModel<int> firstWhereInt(
      int value, List<BaseOpntionModel<int>> values) {
    return values.firstWhere((option) => option.value == value,
        orElse: () => values.first);
  }

  BaseOpntionModel<bool> firstWhereBool(
      bool value, List<BaseOpntionModel<bool>> values) {
    return values.firstWhere(
        (option) => option.value.toString() == value.toString(),
        orElse: () => values.first);
  }
}
