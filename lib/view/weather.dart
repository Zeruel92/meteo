import 'package:flutter/material.dart';
import 'package:meteo/bloc/openweather_bloc.dart';
import 'package:meteo/events/bloc_state.dart';
import 'package:meteo/model/openweather.dart';

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocState>(
        stream: OpenWeatherBloc.instance.state,
        builder: (context, snapshot) {
          return (snapshot.data == BlocState.FINISHED)
              ? Container(
                  child: Center(
                    child: StreamBuilder<OpenWeather>(
                        stream: OpenWeatherBloc.instance.current,
                        builder: (context, weather) {
                          return weather.hasData
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('${weather.data.icon}'),
                                    Text('${weather.data.description}'),
                                    Text(
                                        'Temperature: ${weather.data.temperatureCelsius} °C'),
                                    Text(
                                        'Min: ${weather.data.temperatureMinCelsius} °C'),
                                    Text(
                                        'Max: ${weather.data.temperatureMaxCelsius} °C'),
                                    Text(
                                        'Feels Like: ${weather.data.temperatureFeelsLikeCelsius} °C')
                                  ],
                                )
                              : CircularProgressIndicator();
                        }),
                  ),
                )
              : (snapshot.data == BlocState.BUSY)
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child:
                          Text('Impossibile ricevere i dati meteo al momento'),
                    );
        });
  }
}
