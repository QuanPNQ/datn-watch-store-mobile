import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/ui/components/progress_indicator/loading_progress.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';

class LoadingHelper {
  static showLoading(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.loaderOverlay.show(widget: const Center(child: LoadingProgress()));
  }

  static hideLoading(BuildContext context) {
    context.loaderOverlay.hide();
  }
}
