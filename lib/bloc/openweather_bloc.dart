import 'dart:convert';

import 'package:meteo/events/bloc_state.dart';
import 'package:meteo/events/openweather_events.dart';
import 'package:meteo/model/openweather.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class OpenWeatherBloc {
  static final OpenWeatherBloc _instance = OpenWeatherBloc._private();
  static OpenWeatherBloc get instance => _instance;

  BehaviorSubject<OpenWeather> _currentWeather;
  BehaviorSubject<OpenWeatherEvent> _event;
  BehaviorSubject<BlocState> _internalState;

  final _apiKey = "#{APIKEY}#";

  Stream get current => _currentWeather.stream;
  Sink get event => _event.sink;
  Stream get state => _internalState.stream;

  OpenWeatherBloc._private() {
    _currentWeather = BehaviorSubject();
    _event = BehaviorSubject();
    _internalState = BehaviorSubject.seeded(BlocState.BUSY);
    _event.stream.listen(eventListener);
    fetchCurrent();
  }

  void fetchCurrent() async {
    _internalState.sink.add(BlocState.BUSY);
    final current =
        "https://api.openweathermap.org/data/2.5/weather?q=Lecce,it&appid=$_apiKey";
    try {
      final response = await http.get(current);
      final currentData = OpenWeather.fromJson(json.decode(response.body));
      _currentWeather.sink.add(currentData);
      _internalState.sink.add(BlocState.FINISHED);
    } catch (e) {
      _internalState.sink.add(BlocState.ERROR);
    }
  }

  void eventListener(OpenWeatherEvent event) {
    if (event == OpenWeatherEvent.REFRESH) {
      fetchCurrent();
    }
  }

  void dispose() {
    _currentWeather.close();
    _event.close();
    _internalState.close();
  }
}
