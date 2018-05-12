
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xftz/widgets/main_menu/quote_scrollable_tabs.dart';

typedef Widget GalleryDemoBuilder();

class GalleryItem {
  const GalleryItem({
    @required this.routeName,
    @required this.buildRoute,
  })  : assert(routeName != null),
        assert(buildRoute != null);

  final String routeName;
  final WidgetBuilder buildRoute;
}

List<GalleryItem> _buildGalleryItems() {
  // When editing this list, make sure you keep it in sync with
  // the list in ../../test_driver/transitions_perf_test.dart
  final List<GalleryItem> galleryItems = <GalleryItem>[

    new GalleryItem(

      routeName: QutoeScrollableTabs.routeName,
      buildRoute: (BuildContext context) => new QutoeScrollableTabs(),
    )

  ];

  return galleryItems;
}

final List<GalleryItem> kAllGalleryItems = _buildGalleryItems();
