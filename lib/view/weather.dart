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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
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
                                            'Feels Like: ${weather.data.temperatureFeelsLikeCelsius} °C'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset('${weather.data.icon}'),
                                            Text('Tomorrow')
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset('${weather.data.icon}'),
                                            Text('2- Days Forecast')
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset('${weather.data.icon}'),
                                            Text('3-Days Forecast')
                                          ],
                                        )
                                      ],
                                    )
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
