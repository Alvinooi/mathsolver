import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'crop_image_model.dart';
export 'crop_image_model.dart';

class CropImageWidget extends StatefulWidget {
  const CropImageWidget({
    super.key,
    required this.uploadUrl,
    required this.onCompleted,
  });

  final String? uploadUrl;
  final Future Function(String completedImageUrl)? onCompleted;

  @override
  State<CropImageWidget> createState() => _CropImageWidgetState();
}

class _CropImageWidgetState extends State<CropImageWidget> {
  late CropImageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CropImageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500.0,
      child: custom_widgets.ImageCropperWidget(
        width: double.infinity,
        height: 500.0,
        imageUrl: widget.uploadUrl!,
        userId: currentUserUid,
        onCropCompleted: (uploadedImagePath) async {
          await widget.onCompleted?.call(
            uploadedImagePath,
          );
        },
      ),
    );
  }
}
