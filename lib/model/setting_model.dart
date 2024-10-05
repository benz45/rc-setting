import 'dart:convert';

import 'package:rc_setting/model/screen_size_model.dart';

ConfigModel settingModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String settingModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
    int currentProfile;
    ProfileConfig profile1;
    ProfileConfig profile2;
    ProfileConfig profile3;

    ConfigModel({
        required this.currentProfile,
        required this.profile1,
        required this.profile2,
        required this.profile3,
    });

    factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        currentProfile: json['currentProfile'],
        profile1: ProfileConfig.fromJson(json['profile1']),
        profile2: ProfileConfig.fromJson(json['profile2']),
        profile3: ProfileConfig.fromJson(json['profile3']),
    );

    Map<String, dynamic> toJson() => {
        'currentProfile': currentProfile,
        'profile1': profile1.toJson(),
        'profile2': profile2.toJson(),
        'profile3': profile3.toJson(),
    };
}

class ProfileConfig {
    bool preventTaskbarOverlap;
    int performance;
    bool screenMode;
    ScreenSizeModel screenSize;
    int screenFramerate;
    int sightDistance;
    int carCountLevel;
    int carTexLevel;
    int carEffectLevel;
    int envmapLevel;
    int fieldLevel;
    int texDetailLevel;
    int lightTexDetailLevel;
    bool reflection;
    bool sceneGlowOn;
    bool motionBlurOn;
    int multiSampleType;
    int carLodLevel;
    bool renderSignboard;
    bool waterReflection;
    int bloomLevel;
    int dynLight2;

    ProfileConfig({
        required this.preventTaskbarOverlap,
        required this.performance,
        required this.screenMode,
        required this.screenSize,
        required this.screenFramerate,
        required this.sightDistance,
        required this.carCountLevel,
        required this.carTexLevel,
        required this.carEffectLevel,
        required this.envmapLevel,
        required this.fieldLevel,
        required this.texDetailLevel,
        required this.lightTexDetailLevel,
        required this.reflection,
        required this.sceneGlowOn,
        required this.motionBlurOn,
        required this.multiSampleType,
        required this.carLodLevel,
        required this.renderSignboard,
        required this.waterReflection,
        required this.bloomLevel,
        required this.dynLight2,
    });

    factory ProfileConfig.fromJson(Map<String, dynamic> json) => ProfileConfig(
        preventTaskbarOverlap: json['preventTaskbarOverlap'],
        performance: json['performance'],
        screenMode: json['screenMode'],
        screenSize: ScreenSizeModel.fromJson(json['screenSize']),
        screenFramerate: json['screenFramerate'],
        sightDistance: json['sightDistance'],
        carCountLevel: json['carCountLevel'],
        carTexLevel: json['carTexLevel'],
        carEffectLevel: json['carEffectLevel'],
        envmapLevel: json['envmapLevel'],
        fieldLevel: json['fieldLevel'],
        texDetailLevel: json['texDetailLevel'],
        lightTexDetailLevel: json['lightTexDetailLevel'],
        reflection: json['reflection'],
        sceneGlowOn: json['sceneGlowOn'],
        motionBlurOn: json['motionBlurOn'],
        multiSampleType: json['multiSampleType'],
        carLodLevel: json['carLodLevel'],
        renderSignboard: json['renderSignboard'],
        waterReflection: json['waterReflection'],
        bloomLevel: json['bloomLevel'],
        dynLight2: json['dynLight2'],
    );

    Map<String, dynamic> toJson() => {
        'preventTaskbarOverlap': preventTaskbarOverlap,
        'performance': performance,
        'screenMode': screenMode,
        'screenSize': screenSize.toJson(),
        'screenFramerate': screenFramerate,
        'sightDistance': sightDistance,
        'carCountLevel': carCountLevel,
        'carTexLevel': carTexLevel,
        'carEffectLevel': carEffectLevel,
        'envmapLevel': envmapLevel,
        'fieldLevel': fieldLevel,
        'texDetailLevel': texDetailLevel,
        'lightTexDetailLevel': lightTexDetailLevel,
        'reflection': reflection,
        'sceneGlowOn': sceneGlowOn,
        'motionBlurOn': motionBlurOn,
        'multiSampleType': multiSampleType,
        'carLodLevel': carLodLevel,
        'renderSignboard': renderSignboard,
        'waterReflection': waterReflection,
        'bloomLevel': bloomLevel,
        'dynLight2': dynLight2,
    };
}
