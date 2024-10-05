class SettingDefaultModel {
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

    SettingDefaultModel({
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

    factory SettingDefaultModel.fromJson(Map<String, dynamic> json) => SettingDefaultModel(
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

