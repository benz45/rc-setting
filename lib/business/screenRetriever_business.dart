import 'package:rc_setting/model/screen_size_model.dart';
import 'package:screen_retriever/screen_retriever.dart';

class ScreenRetrieverBusiness {
  Future<ScreenSizeModel?> getScreenSize() async {
    Display? primaryDisplay = await screenRetriever.getPrimaryDisplay();
    if (primaryDisplay != null) {
      return ScreenSizeModel(
          width: primaryDisplay.size.width.toInt(),
          height: primaryDisplay.size.height.toInt());
    }
    return null;
  }
}
