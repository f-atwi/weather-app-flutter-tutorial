import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/ripple_wrapper.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
        body: Padding(
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "18C",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.cloud,
                            size: 96,
                          ),
                          Text(
                            "Rain",
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItem(
                    icon: Icons.water_drop,
                    label: "Humidity",
                    value: "94",
                  ),
                  AdditionalInfoItem(
                      icon: Icons.air, label: "Wind Speed", value: "12 km/h"),
                  AdditionalInfoItem(
                      icon: Icons.thermostat,
                      label: "Pressure",
                      value: "1 atm"),
                ],
              )
            ],
          ),
        ));
  }
}
