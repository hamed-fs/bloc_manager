import 'package:flutter/material.dart';

import 'package:flutter_bloc_manager/bloc/sample_bloc.dart';
import 'package:flutter_bloc_manager/bloc_manager.dart';

void main() {
  BlocManager.instance.register<SampleBloc>(() => SampleBloc());
  final SampleBloc sampleBloc = BlocManager.instance.fetch<SampleBloc>();

  print(sampleBloc);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}
