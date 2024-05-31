import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/ui/components/progress_indicator/dot_indicator/dot_loading_indicator.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';

class LoadingHelper {
  static showLoading(BuildContext context) {
    context.loaderOverlay
        .show(widget: const Center(child: DotLoadingIndicator()));
  }

  static hideLoading(BuildContext context) {
    context.loaderOverlay.hide();
  }
}
