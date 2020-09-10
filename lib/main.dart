import 'package:flutter/material.dart';
import 'package:flutter_bloc_manager/bloc/connectivity_bloc.dart';

import 'package:flutter_bloc_manager/bloc/sample_bloc.dart';
import 'package:flutter_bloc_manager/bloc_manager.dart';

void main() {
  runApp(MyApp());

  BlocManager.instance.register<ConnectivityBloc>(() => ConnectivityBloc());
  BlocManager.instance.register<SampleBloc>(() => SampleBloc());
  BlocManager.instance.fetch<SampleBloc>();

  print('01');

  BlocManager.instance.fetch<ConnectivityBloc>().add(UpdateConnectivity());
  BlocManager.instance.fetch<ConnectivityBloc>().add(UpdateConnectivity());

  print('02');

  Future<void>.delayed(const Duration(seconds: 10), () {
    BlocManager.instance.removeListener('Connectivity');
    BlocManager.instance.fetch<ConnectivityBloc>().add(UpdateConnectivity());
    print('04');
  });

  print('03');

  print(BlocManager.instance.fetch<SampleBloc>());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(),
    );
}
