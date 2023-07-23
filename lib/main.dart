import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:localtrysession/dashboard.dart';
import 'package:localtrysession/login.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;
  final sessionStateStream = StreamController<SessionState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 5),
      invalidateSessionForUserInactivity: const Duration(seconds: 4),
    );
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // stop listening, as user will already be in auth page
      sessionStateStream.add(SessionState.stopListening);
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout
        _navigator.push(MaterialPageRoute(
          builder: (_) => Login(
              sessionStateStream: sessionStateStream,

        )));
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        _navigator.push(MaterialPageRoute(
          builder: (_) => Login(
              sessionStateStream: sessionStateStream,
        )));
      }
    });
    return SessionTimeoutManager(
      userActivityDebounceDuration: const Duration(seconds: 1),
      sessionConfig: sessionConfig,
      sessionStateStream: sessionStateStream.stream,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Login(
          sessionStateStream: sessionStateStream,
        ),
      ),
    );
  }
}



