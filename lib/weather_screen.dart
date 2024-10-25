import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/ripple_wrapper.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Cergy,fr";
      final result = await http.get(
        Uri.parse(
            "http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherMapAPIKey"),
      );
      final forecastData = jsonDecode(result.body);
      if (forecastData["cod"] != "200") {
        throw "An unexpected error occured";
      }
      return forecastData;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;
          final currentWeatherData = data["list"][0];
          final currentTemp =
              ((currentWeatherData["main"]["temp"] - 273.15) * 10).round() / 10;
          final currentSky = currentWeatherData["weather"][0]["description"];
          final currentPressure = currentWeatherData["main"]["pressure"];
          final currentWindSpeed = currentWeatherData["wind"]["speed"];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: RippleWrapper(
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "$currentTemp°C",
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.cloud,
                              size: 96,
                            ),
                            Text(
                              "$currentSky",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Weather Forecast",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecastItem(
                        time: "00:00",
                        icon: Icons.sunny,
                        temperature: "23C",
                      ),
                      HourlyForecastItem(
                        time: "03:00",
                        icon: Icons.cloud,
                        temperature: "22C",
                      ),
                      HourlyForecastItem(
                        time: "06:00",
                        icon: Icons.cloud,
                        temperature: "21C",
                      ),
                      HourlyForecastItem(
                        time: "09:00",
                        icon: Icons.cloud,
                        temperature: "20C",
                      ),
                      HourlyForecastItem(
                        time: "12:00",
                        icon: Icons.cloud,
                        temperature: "29C",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: "94",
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: "Wind Speed",
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                        icon: Icons.thermostat,
                        label: "Pressure",
                        value: currentPressure.toString()),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
