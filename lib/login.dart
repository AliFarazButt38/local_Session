import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:localtrysession/dashboard.dart';

class Login extends StatefulWidget {
  final StreamController<SessionState> sessionStateStream;

  const Login({
    required this.sessionStateStream,

    Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: ElevatedButton(onPressed: () async{
              widget.sessionStateStream.add(SessionState.startListening);
             await Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPage(sessionStateStream: widget.sessionStateStream)));

            }, child: Text('Go to dasboard')),
          ),
    );
  }
}
