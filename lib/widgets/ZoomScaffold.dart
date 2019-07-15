import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ZoomScaffold extends StatefulWidget {
  final Widget menuScreen;
  final Layout contentScreen;
  final Stream actionTogle;

  ZoomScaffold({this.menuScreen, this.contentScreen, this.actionTogle});

  @override
  _ZoomScaffoldState createState() => new _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold>
    with TickerProviderStateMixin {
  StreamSubscription _subscription;
  var title = '';
  MenuController menuController;

  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    _subscription = widget.actionTogle.listen((params) => {
          title = params,
          startToggle(),
        });
    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(ZoomScaffold oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.actionTogle != oldWidget.actionTogle) {
      _subscription.cancel();
      _subscription = widget.actionTogle.listen((_) => startToggle());
    }
  }

  @override
  void dispose() {
    super.dispose();
    menuController.dispose();
    _subscription.cancel();
  }

  createContentDisplay() {
    return zoomAndSlideContent(new Container(
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          brightness: Brightness.light,
          title: TextWidget(
            txt: title,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Image.asset(
                'lib/assets/images/ic_burger.png',
                height: 20,
              ),
              onPressed: () {
                startToggle();
              }),
          actions: <Widget>[
            title == ''
                ? Image.asset(
                    'lib/assets/images/logo_small.png',
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  )
                : Container()
          ],
        ),
        body: widget.contentScreen.contentBuilder(context),
      ),
    ));
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent;
    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        break;
    }

    final slideAmount =
        (MediaQuery.of(context).size.width / 1.5) * slidePercent;
    final contentScale = 1.0;
    final cornerRadius = 16.0 * menuController.percentOpen;

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              offset: const Offset(0.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
            borderRadius: new BorderRadius.circular(cornerRadius),
            child: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Scaffold(
            body: GestureDetector(
              key: ValueKey('GestureZoom'),
              child: widget.menuScreen,
              onTap: () => {startToggle()},
            ),
          ),
        ),
        createContentDisplay()
      ],
    );
  }

  startToggle() {
    menuController.toggle();
  }
}

class Layout {
  final WidgetBuilder contentBuilder;

  Layout({
    this.contentBuilder,
  });
}

class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  MenuController({
    this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}
