//Taken from https://stackoverflow.com/questions/57856561/how-to-check-when-my-widget-screen-comes-to-visibility-in-flutter-like-onresume


import 'dart:async';
import 'package:bus_driver/main.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), (){
      Navigator.push(context, EventRoute(context, builder: (context) =>  BaseScreen(),
          onCreate: (context) => null,
          onDestroy: (context) => Navigator.push(context,
              MaterialPageRoute(builder: (context)=> const BaseScreen()
              )
          ),
          onBackground: (context) => null,
          onForeground: (context) => print('fore')
      ));

    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            // Image.asset("assets/images/logo.png",
            //   height: size.width * 0.25,
            //   width: size.width * 0.25,
            // ),
            Placeholder(fallbackHeight: size.width * 0.25, fallbackWidth: size.width * 0.25,),
            const Spacer(),
            const Text("from", style: TextStyle(color: Colors.grey),),
            const Text("Team Arachnida"),
            SizedBox(
              height: size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}





enum RouteState {
  none,
  created,
  foreground,
  background,
  destroyed
}

class EventRoute<T> extends MaterialPageRoute<T> {
  final BuildContext _context;
  RouteState _state;
  final Function(BuildContext) _onCreateCallback;
  final Function(BuildContext) _onForegroundCallback;
  final Function(BuildContext) _onBackgroundCallback;
  final Function(BuildContext) _onDestroyCallback;

  EventRoute(BuildContext context, {
    builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    required Function(BuildContext) onCreate,
    required Function(BuildContext) onForeground,
    required Function(BuildContext) onBackground,
    required Function(BuildContext) onDestroy
  }):
        _context = context,
        _onCreateCallback = onCreate,
        _onForegroundCallback = onForeground,
        _onBackgroundCallback = onBackground,
        _onDestroyCallback = onDestroy,
        _state = RouteState.none,
        super(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);


  void get state => _state;

  @override
  void didChangeNext(Route? nextRoute) {
    if (nextRoute == null) {
      _onForeground();
    } else {
      _onBackground();
    }
    super.didChangeNext(nextRoute);
  }

  @override
  bool didPop(T? result) {
    _onDestroy();
    return super.didPop(result);
  }

  @override
  void didPopNext(Route nextRoute) {
    _onForeground();
    super.didPopNext(nextRoute);
  }

  @override
  TickerFuture didPush() {
    _onCreate();
    return super.didPush();
  }

  @override
  void didReplace(Route? oldRoute) {
    _onForeground();
    super.didReplace(oldRoute);
  }

  void _onCreate() {
    if (_state != RouteState.none ) {
      return;
    }
    _onCreateCallback(_context);
  }

  void _onForeground() {
    if (_state == RouteState.foreground) {
      return;
    }
    _state = RouteState.foreground;
    // if (_onForegroundCallback != null) {
      _onForegroundCallback(_context);
    // }
  }

  void _onBackground() {
    if (_state == RouteState.background) {
      return;
    }
    _state = RouteState.background;
    // if (_onBackgroundCallback != null) {
      _onBackgroundCallback(_context);
    // }
  }

  void _onDestroy() {
    if (_state == RouteState.destroyed) {
      return;
    }
    _onDestroyCallback(_context);
  }
}