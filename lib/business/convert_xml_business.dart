import 'package:rc_setting/constant/option_constant.dart';
import 'package:rc_setting/model/screen_size_model.dart';
import 'package:rc_setting/model/setting_model.dart';
import 'package:xml/xml.dart';

class ConvertXMLBusiness {
  convertToGraphic(XmlElement? elem, ProfileConfig config, bool isActivated) {
    if (elem != null) {
      ScreenSizeModel size = getScreenSize(config);
      convert(elem, FULL_SCREEN_WIDTH, size.width);
      convert(elem, FULL_SCREEN_HEIGHT, size.height);
      convert(elem, WINDOW_SCREEN_HEIGHT, size.height);
      convert(elem, WINDOW_SCREEN_WIDTH, size.width);
      convert(elem, SCREEN_HZ, config.screenFramerate);
      if (isActivated) {
        convert(elem, SIGHT_DISTANCE, config.sightDistance);
        convert(elem, CAR_COUNT_LEVEL, config.carCountLevel);
        convert(elem, CAR_TEX_LEVEL, config.carTexLevel);
        convert(elem, ENVMAP_LEVEL, config.envmapLevel);
        convert(elem, FIELD_LEVEL, config.fieldLevel);
        convert(elem, TEX_DETAIL_LEVEL, config.texDetailLevel);
        convert(elem, LIGHT_TEX_DETAIL_LEVEL, config.lightTexDetailLevel);
        convert(elem, REFLECTION, config.reflection);
        convert(elem, SCENE_GLOW_ON, config.sceneGlowOn);
        convert(elem, MOTION_BLUR_ON, config.motionBlurOn);
        convert(elem, MULTI_SAMPLE_TYPE, config.multiSampleType);
        convert(elem, CAR_LOD_LEVEL, config.carLodLevel);
        convert(elem, RENDER_SIGNBOARD, config.renderSignboard);
        convert(elem, WATER_REFLECTION, config.waterReflection);
        convert(elem, BLOOM_LEVEL, config.bloomLevel);
        convert(elem, DYN_LIGHT2, config.dynLight2);
      }
    }
  }

  void convert<T>(XmlElement element, String key, T? value) {
    if (value != null) {
      element.setAttribute(key, value.toString());
    }
  }

  getScreenSize(ProfileConfig config) {
    late int width;
    late int height;
    if (config.screenSize?.width != null && config.screenSize?.height != null) {
      width = config.screenSize.width;
      height = config.screenSize.height;
      if (config.preventTaskbarOverlap) {
        height -= 72;
      }
    }
    return ScreenSizeModel(width: width, height: height);
  }
}
