import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';


class NextPage extends StatefulWidget {
  const NextPage({
    Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('next page'),
      ),
    );
  }
}
