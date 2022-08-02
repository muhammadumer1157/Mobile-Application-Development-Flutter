/*
Name: Muhammad Umer
Roll No.: 19-NTU-CS-1157
Degree and Semester: BSIT-6th
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
        textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 15,
        fontFamily: "Roboto",
        color: Color(0xFFFFFFFF),
      ),
      bodyText2: TextStyle(
        fontSize: 20,
        fontFamily: "Roboto",
        color: Color(0xFFFFFFFF),
      ),
      headline1: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
        color: Color(0xFFFFFFFF),
      ),
      headline2: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
        color: Color(0xFFFFFFFF),
      ),
      headline3: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
        color: Color(0xFFFFFFFF),
      ),
      headline4: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
        color: Color(0xFFFFFFFF),
      ),
      headline5: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
        color: Color(0xFFFFFFFF),
      ),
    )),
    home: const SafeArea(child: WeatherAppHomePage()),
  ));
}

class WeatherAppHomePage extends StatefulWidget {
  const WeatherAppHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherAppHomePage> createState() => _WeatherAppHomePageState();
}

class _WeatherAppHomePageState extends State<WeatherAppHomePage> {
  double longitude = 0.0;
  double latitude = 0.0;
  String temperature = "";
  String temperatureMin = "";
  String temperatureMax = "";
  String feelsLike = "";
  int humidity = 0;
  double wind = 0.0;
  int cloudiness = 0;
  String city = "";
  String description = "";
  String weather = "";
  String iconId = "";
  bool locationFound = false;

  @override
  void initState() {
    fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: getGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: !locationFound
              ? Text(
                  "Wait a moment!",
                  style: Theme.of(context).textTheme.bodyText1,
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Weather Forecast",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      city,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      weather,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.asset(imageSelection(), height: 200, width: 200),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                temperature.toString() + "°",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Text(
                                "Feels Like " + feelsLike + "°",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    MinMaxContainer(
                                        temperatureMax.toString(),
                                        "Max",
                                        Theme.of(context).textTheme.headline5,
                                        Theme.of(context).textTheme.headline4),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    MinMaxContainer(
                                        temperatureMin.toString(),
                                        "Min",
                                        Theme.of(context).textTheme.bodyText2,
                                        Theme.of(context).textTheme.bodyText1)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BottomContainer(humidity.toString(), "%", "Humidity",
                            "assets/Humidity.png"),
                        BottomContainer(wind.toString(), "m/s", "Wind Speed",
                            "assets/Wind.png"),
                        BottomContainer(cloudiness.toString(), "%",
                            "Cloudiness", "assets/Cloudiness.png")
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }

  void fetchLocation() async {
    bool permission = false;
    LocationPermission checkpermission = await Geolocator.checkPermission();
    if (checkpermission == LocationPermission.denied ||
        checkpermission == LocationPermission.deniedForever) {
      LocationPermission requestpermission =
          await Geolocator.requestPermission();
      if (requestpermission == LocationPermission.whileInUse ||
          requestpermission == LocationPermission.always) {
        permission = true;
      }
    } else {
      permission = true;
    }
    if (permission) {
      Position currentLog = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      locationFound = true;
      latitude = currentLog.latitude;
      longitude = currentLog.longitude;
      fetchWeather();
    }
  }

  void fetchWeather() async {
    const String apiKey = '70fb398a04267a3aa148ce768f320d25';
    String urlString =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    var url = Uri.parse(urlString);
    http.Response response = await http.get(url);
    var responseBody = response.body;
    var parsedResponse = jsonDecode(responseBody);
    setState(() {
      temperature = kelvinToCelsius(parsedResponse['main']['temp']);
      temperatureMin = kelvinToCelsius(parsedResponse['main']['temp_min']);
      temperatureMax = kelvinToCelsius(parsedResponse['main']['temp_max']);
      feelsLike = kelvinToCelsius(parsedResponse['main']['feels_like']);
      humidity = parsedResponse['main']['humidity'];
      wind = parsedResponse['wind']['speed'];
      cloudiness = parsedResponse['clouds']['all'];
      city = parsedResponse['name'];
      description = parsedResponse['weather'][0]['description'];
      weather = parsedResponse['weather'][0]['main'];
      iconId = parsedResponse['weather'][0]['icon'];
    });
  }

  String kelvinToCelsius(double t) {
    return (t - 273.15).toStringAsFixed(1);
  }

  String imageSelection() {
    if (iconId == "01n") {
      return "assets/ClearNight.png";
    } else if (iconId == "02d") {
      return "assets/CloudyDay.png";
    } else if (iconId == "02n") {
      return "assets/CloudyNight.png";
    } else if (iconId == "03d" ||
        iconId == "03n" ||
        iconId == "04d" ||
        iconId == "04n") {
      return "assets/Clouds.png";
    } else if (iconId == "09d" ||
        iconId == "09n" ||
        iconId == "010d" ||
        iconId == "010n") {
      return "assets/Rain.png";
    } else if (iconId == "11d" || iconId == "11n") {
      return "assets/Thunderstorm.png";
    } else if (iconId == "13d" || iconId == "13n") {
      return "assets/Snow.png";
    } else if (iconId == "50d" || iconId == "50n") {
      return "assets/Atmosphere.png";
    } else {
      return "assets/ClearDay.png";
    }
  }

  LinearGradient getGradient() {
    if (iconId == "01d" ||
        iconId == "02d" ||
        iconId == "03d" ||
        iconId == "04d" ||
        iconId == "50d") {
      return const LinearGradient(
        colors: [Color(0xff64bbf9), Color(0xff3d9de7)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (iconId == "01n" ||
        iconId == "02n" ||
        iconId == "03n" ||
        iconId == "04n" ||
        iconId == "50n") {
      return const LinearGradient(
        colors: [Color(0xff0767b3), Color(0xff055592)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else if (iconId == "09d" ||
        iconId == "09n" ||
        iconId == "10d" ||
        iconId == "10n" ||
        iconId == "11d" ||
        iconId == "11n") {
      return const LinearGradient(
        colors: [Color(0xff37587b), Color(0xff4f7fad)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (iconId == "13d" || iconId == "13n") {
      return const LinearGradient(
        colors: [Color(0xff61abe8), Color(0xff3194e5)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xff64bbf9), Color(0xff3d9de7)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
  }
}

class BottomContainer extends StatelessWidget {
  final String value;
  final String unit;
  final String text;
  final String imagePath;
  const BottomContainer(this.value, this.unit, this.text, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 50,
          width: 50,
        ),
        Text(
          value + unit,
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

class MinMaxContainer extends StatelessWidget {
  final String temperatureValue;
  final String text;
  final TextStyle? themeInfo1;
  final TextStyle? themeInfo2;
  const MinMaxContainer(
      this.temperatureValue, this.text, this.themeInfo1, this.themeInfo2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          temperatureValue.toString() + "°",
          style: themeInfo1,
        ),
        Text(
          text,
          style: themeInfo2,
        )
      ],
    );
  }
}
