class ScreenSizeModel {
    int height;
    int width;

    ScreenSizeModel({
        required this.height,
        required this.width,
    });

    String getText() {
      if (width == 0 && height == 0) {
        return 'กรุณาเลือก';

      }
      return '${width.toString()}x${height.toString()}';
    }
    
    String id() {
      return '${width.toString()}${height.toString()}';
    }

    factory ScreenSizeModel.fromJson(Map<String, dynamic> json) => ScreenSizeModel(
        height: json['height'],
        width: json['width'],
    );

    Map<String, dynamic> toJson() => {
        'height': height,
        'width': width,
    };
}
