import 'package:rc_setting/model/base_option_model.dart';
import 'package:rc_setting/model/screen_size_model.dart';
import 'package:rc_setting/model/setting_default_model.dart';
import 'package:rc_setting/model/setting_model.dart';

// คุณภาพ
final List<BaseOpntionModel<int>> performanceList = [
  BaseOpntionModel(title: 'กำหนดเอง', value: 5),
  BaseOpntionModel(title: 'ต่ำ', value: 3),
  BaseOpntionModel(title: 'กลาง', value: 2),
  BaseOpntionModel(title: 'สูง', value: 1),
  BaseOpntionModel(title: 'สูงมาก', value: 0),
];

// หน้าจอ
final List<BaseOpntionModel<bool>> screenModeList = [
  BaseOpntionModel(title: 'Full Screen', value: true),
  BaseOpntionModel(title: 'Window', value: false),
];

// ขนาดหน้าจอ
final List<ScreenSizeModel> screenSizeList = [
  ScreenSizeModel(width: 0, height: 0),
  ScreenSizeModel(width: 2560, height: 1080),
  ScreenSizeModel(width: 1920, height: 1080),
  ScreenSizeModel(width: 1280, height: 720),
  ScreenSizeModel(width: 800, height: 600),
];

// screenHz
final List<BaseOpntionModel<int>> screenFramerateList = [
  BaseOpntionModel(title: '240Hz', value: 240),
  BaseOpntionModel(title: '180Hz', value: 180),
  BaseOpntionModel(title: '144Hz', value: 144),
  BaseOpntionModel(title: '120Hz', value: 120),
  BaseOpntionModel(title: '100Hz', value: 100),
  BaseOpntionModel(title: '90Hz', value: 90),
  BaseOpntionModel(title: '75Hz', value: 75),
  BaseOpntionModel(title: '60Hz', value: 60),
];

// ระยะการมองเห็น
final List<BaseOpntionModel<int>> sightDistanceList = [
  BaseOpntionModel(title: '300m', value: 7),
  BaseOpntionModel(title: '400m', value: 6),
  BaseOpntionModel(title: '500m', value: 5),
  BaseOpntionModel(title: '600m', value: 4),
  BaseOpntionModel(title: '700m', value: 3),
  BaseOpntionModel(title: '800m', value: 2),
  BaseOpntionModel(title: '900m', value: 1),
  BaseOpntionModel(title: '1000m', value: 0),
];

// ปริมาณรถ
final List<BaseOpntionModel<int>> carCountLevelList = [
  BaseOpntionModel(title: 'ต่ำมาก', value: 4),
  BaseOpntionModel(title: 'ต่ำ', value: 3),
  BaseOpntionModel(title: 'กลาง', value: 2),
  BaseOpntionModel(title: 'สูง', value: 1),
  BaseOpntionModel(title: 'สูงมาก', value: 0),
];

// Texture รถ
final List<BaseOpntionModel<int>> carTexLevelList = [
  BaseOpntionModel(title: 'ต่ำ', value: 1),
  BaseOpntionModel(title: 'สูง', value: 0),
];

// รายละเอียด Effect
final List<BaseOpntionModel<int>> carEffectLevelList = [
  BaseOpntionModel(title: 'ไม่มี', value: 3),
  BaseOpntionModel(title: 'ต่ำ', value: 2),
  BaseOpntionModel(title: 'ปกติ', value: 1),
  BaseOpntionModel(title: 'สูง', value: 0),
];

// เงาสะท้อนของรถ
final List<BaseOpntionModel<int>> envmapLevelList = [
  BaseOpntionModel(title: 'ไม่มี', value: 3),
  BaseOpntionModel(title: 'ต่ำ', value: 2),
  BaseOpntionModel(title: 'ทั่วไป', value: 1),
  BaseOpntionModel(title: 'คุณภาพดี', value: 0),
];

// ภาพ 3 มิติของตึก
final List<BaseOpntionModel<int>> fieldLevelList = [
  BaseOpntionModel(title: 'ต่ำ', value: 1),
  BaseOpntionModel(title: 'สูง', value: 0),
];

// ข้อความปลีกย่อย
final List<BaseOpntionModel<int>> texDetailLevelList = [
  BaseOpntionModel(title: 'ต่ำมาก', value: 2),
  BaseOpntionModel(title: 'ต่ำ', value: 1),
  BaseOpntionModel(title: 'ทั่วไป', value: 0),
];

// รายละเอียดของแสง
final List<BaseOpntionModel<int>> lightTexDetailLevelList = [
  BaseOpntionModel(title: 'ต่ำ', value: 2),
  BaseOpntionModel(title: 'ปกติ', value: 1),
  BaseOpntionModel(title: 'สูง', value: 0),
];

// ภาพสะท้องของตึก
final List<BaseOpntionModel<bool>> reflectionList = [
  BaseOpntionModel(title: 'ปิด', value: false),
  BaseOpntionModel(title: 'เปิด', value: true),
];

// Environment effect
final List<BaseOpntionModel<bool>> sceneGlowOnList = [
  BaseOpntionModel(title: 'ปิด', value: false),
  BaseOpntionModel(title: 'เปิด', value: true),
];

// Booster effect
final List<BaseOpntionModel<bool>> motionBlurOnList = [
  BaseOpntionModel(title: 'ปิด', value: false),
  BaseOpntionModel(title: 'เปิด', value: true),
];

// Antialiasing
final List<BaseOpntionModel<int>> multiSampleTypeList = [
  BaseOpntionModel(title: 'ปิด', value: 0),
  BaseOpntionModel(title: 'เปิด', value: 1),
  BaseOpntionModel(title: 'x2', value: 2),
  BaseOpntionModel(title: 'x4', value: 3),
  BaseOpntionModel(title: 'x8', value: 4),
];

// โพลิกอนของรถ
final List<BaseOpntionModel<int>> carLodLevelList = [
  BaseOpntionModel(title: 'ต่ำ', value: 1),
  BaseOpntionModel(title: 'สูง', value: 0),
];

// ดูข้อมูลสัญลักษณ์
final List<BaseOpntionModel<bool>> renderSignboardList = [
  BaseOpntionModel(title: 'ปิด', value: false),
  BaseOpntionModel(title: 'เปิด', value: true),
];

// ภาพสะท้อน
final List<BaseOpntionModel<bool>> waterReflectionList = [
  BaseOpntionModel(title: 'ปิด', value: false),
  BaseOpntionModel(title: 'เปิด', value: true),
];

// ระเบิด
final List<BaseOpntionModel<int>> bloomLevelList = [
  BaseOpntionModel(title: 'ปิด', value: 0),
  BaseOpntionModel(title: 'ต่ำ', value: 1),
  BaseOpntionModel(title: 'ปกติ', value: 2),
];

// แสงไฟหน้า
final List<BaseOpntionModel<int>> dynLight2List = [
  BaseOpntionModel(title: 'ปิด', value: 0),
  BaseOpntionModel(title: 'เปิด', value: 1),
  BaseOpntionModel(title: 'ข้อมูล', value: 2),
];

// ------------------------------------------------------------------------

final ConfigModel defaultConfig = ConfigModel(
  currentProfile: 1,
  profile1: profileConfigDefault,
  profile2: profileConfigDefault,
  profile3: profileConfigDefault,
);

ProfileConfig profileConfigDefault = ProfileConfig(
  preventTaskbarOverlap: true,
  performance: 1,
  screenMode: true,
  screenSize: ScreenSizeModel(width: 800, height: 600),
  screenFramerate: 60,
  sightDistance: defaultHeight.sightDistance,
  carCountLevel: defaultHeight.carCountLevel,
  carTexLevel: defaultHeight.carTexLevel,
  carEffectLevel: defaultHeight.carEffectLevel,
  envmapLevel: defaultHeight.envmapLevel,
  fieldLevel: defaultHeight.fieldLevel,
  texDetailLevel: defaultHeight.texDetailLevel,
  lightTexDetailLevel: defaultHeight.lightTexDetailLevel,
  reflection: defaultHeight.reflection,
  sceneGlowOn: defaultHeight.sceneGlowOn,
  motionBlurOn: defaultHeight.motionBlurOn,
  multiSampleType: defaultHeight.multiSampleType,
  carLodLevel: defaultHeight.carLodLevel,
  renderSignboard: defaultHeight.renderSignboard,
  waterReflection: defaultHeight.waterReflection,
  bloomLevel: defaultHeight.bloomLevel,
  dynLight2: defaultHeight.dynLight2,
);

SettingDefaultModel defaultUltra = SettingDefaultModel(
  sightDistance: 0,
  carCountLevel: 0,
  carTexLevel: 0,
  carEffectLevel: 0,
  envmapLevel: 0,
  fieldLevel: 0,
  texDetailLevel: 0,
  lightTexDetailLevel: 0,
  reflection: true,
  sceneGlowOn: true,
  motionBlurOn: true,
  multiSampleType: 4,
  carLodLevel: 0,
  renderSignboard: true,
  waterReflection: true,
  bloomLevel: 2,
  dynLight2: 2,
);

SettingDefaultModel defaultHeight = SettingDefaultModel(
  sightDistance: 0,
  carCountLevel: 1,
  carTexLevel: 0,
  carEffectLevel: 0,
  envmapLevel: 1,
  fieldLevel: 0,
  texDetailLevel: 0,
  lightTexDetailLevel: 0,
  reflection: true,
  sceneGlowOn: true,
  motionBlurOn: true,
  multiSampleType: 3,
  carLodLevel: 0,
  renderSignboard: true,
  waterReflection: true,
  bloomLevel: 2,
  dynLight2: 1,
);

SettingDefaultModel defaultMiddle = SettingDefaultModel(
  sightDistance: 2,
  carCountLevel: 1,
  carTexLevel: 0,
  carEffectLevel: 1,
  envmapLevel: 1,
  fieldLevel: 0,
  texDetailLevel: 0,
  lightTexDetailLevel: 1,
  reflection: true,
  sceneGlowOn: true,
  motionBlurOn: true,
  multiSampleType: 1,
  carLodLevel: 0,
  renderSignboard: true,
  waterReflection: true,
  bloomLevel: 2,
  dynLight2: 1,
);

SettingDefaultModel defaultLow = SettingDefaultModel(
  sightDistance: 2,
  carCountLevel: 1,
  carTexLevel: 1,
  carEffectLevel: 2,
  envmapLevel: 2,
  fieldLevel: 1,
  texDetailLevel: 1,
  lightTexDetailLevel: 2,
  reflection: false,
  sceneGlowOn: false,
  motionBlurOn: false,
  multiSampleType: 0,
  carLodLevel: 0,
  renderSignboard: true,
  waterReflection: true,
  bloomLevel: 2,
  dynLight2: 1,
);
