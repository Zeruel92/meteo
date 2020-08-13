import 'package:flutter/material.dart';
import 'package:meteo/bloc/openweather_bloc.dart';
import 'package:meteo/view/weather.dart';

import 'events/openweather_events.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Weather(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () =>
              OpenWeatherBloc.instance.event.add(OpenWeatherEvent.REFRESH),
        ),
      ),
      theme: ThemeData.dark(),
    );
  }
}
