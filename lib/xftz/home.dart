// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xftz/page/bottom_navigation_demo.dart';

import 'drawer.dart';

import 'theme.dart';









class XftzHome extends StatefulWidget {
  const XftzHome({
    Key key,
    this.galleryTheme,
    @required this.onThemeChanged,
    this.timeDilation,
    @required this.onTimeDilationChanged,
    this.textScaleFactor,
    this.onTextScaleFactorChanged,
    this.showPerformanceOverlay,
    this.onShowPerformanceOverlayChanged,
    this.checkerboardRasterCacheImages,
    this.onCheckerboardRasterCacheImagesChanged,
    this.checkerboardOffscreenLayers,
    this.onCheckerboardOffscreenLayersChanged,
    this.onPlatformChanged,
    this.overrideDirection: TextDirection.ltr,
    this.onOverrideDirectionChanged,
    this.onSendFeedback,
  }) : assert(onThemeChanged != null),
       assert(onTimeDilationChanged != null),
       super(key: key);

  // In checked mode our MaterialApp will show the default "debug" banner.
  // Otherwise show the "preview" banner.
  static bool showPreviewBanner = true;

  final GalleryTheme galleryTheme;
  final ValueChanged<GalleryTheme> onThemeChanged;

  final double timeDilation;
  final ValueChanged<double> onTimeDilationChanged;

  final double textScaleFactor;
  final ValueChanged<double> onTextScaleFactorChanged;

  final bool showPerformanceOverlay;
  final ValueChanged<bool> onShowPerformanceOverlayChanged;

  final bool checkerboardRasterCacheImages;
  final ValueChanged<bool> onCheckerboardRasterCacheImagesChanged;

  final bool checkerboardOffscreenLayers;
  final ValueChanged<bool> onCheckerboardOffscreenLayersChanged;

  final ValueChanged<TargetPlatform> onPlatformChanged;

  final TextDirection overrideDirection;
  final ValueChanged<TextDirection> onOverrideDirectionChanged;

  final VoidCallback onSendFeedback;

  @override
  XftzHomeState createState() => new XftzHomeState();
}

class XftzHomeState extends State<XftzHome> with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController _controller;

  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;


  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 600),
      debugLabel: 'preview banner',
      vsync: this,
    )..forward();

    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.access_alarm),
        title: 'Alarm',
        color: Colors.deepPurple,
        vsync: this,
      ),
      new NavigationIconView(
        icon: new CustomIcon(),
        title: 'Box',
        color: Colors.deepOrange,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.cloud),
        title: 'Cloud',
        color: Colors.teal,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        title: 'Favorites',
        color: Colors.indigo,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: 'Event',
        color: Colors.pink,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;

  }


  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }
  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );


    Widget home = new Scaffold(
      key: _scaffoldKey,
      drawer: new GalleryDrawer(
        galleryTheme: widget.galleryTheme,
        onThemeChanged: widget.onThemeChanged,
        timeDilation: widget.timeDilation,
        onTimeDilationChanged: widget.onTimeDilationChanged,
        textScaleFactor: widget.textScaleFactor,
        onTextScaleFactorChanged: widget.onTextScaleFactorChanged,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        onShowPerformanceOverlayChanged: widget.onShowPerformanceOverlayChanged,
        checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
        onCheckerboardRasterCacheImagesChanged: widget.onCheckerboardRasterCacheImagesChanged,
        checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
        onCheckerboardOffscreenLayersChanged: widget.onCheckerboardOffscreenLayersChanged,
        onPlatformChanged: widget.onPlatformChanged,
        overrideDirection: widget.overrideDirection,
        onOverrideDirectionChanged: widget.onOverrideDirectionChanged,
        onSendFeedback: widget.onSendFeedback,
      ),
      appBar: new AppBar(
          title: const Text('Bottom navigation')),
      body: new Center(
          child: _buildTransitionsStack()
      ),
      bottomNavigationBar: botNavBar,

    );

    if (XftzHome.showPreviewBanner) {
      home = new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          home,
          new FadeTransition(
            opacity: new CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
            child: const Banner(
              message: 'PREVIEW',
              location: BannerLocation.topEnd,
            )
          ),
        ]
      );
    }

    return home;
  }
}
