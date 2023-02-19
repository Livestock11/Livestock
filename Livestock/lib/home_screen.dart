import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livestock/DisplayPdfScreen.dart';
import 'package:livestock/ReadPDF.dart';
import 'package:livestock/information_management.dart';
import 'package:livestock/location_screen.dart';
import 'package:livestock/search.dart';
import 'package:livestock/services/weather.dart';
import 'package:livestock/utilities/constants.dart';
import 'package:livestock/utils.dart';




const languages = const [

  const Language('Urdu', 'ur_PK'),

];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  String _currentLocale = 'ur_PK';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
    // updateUI(widget.locationWeather);
  }

  WeatherModel weather = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? areaName;
  String? weatherMessage;



  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = weather.getWeatherIcon(temperature!);
        weatherMessage = '';
        areaName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature!);
      areaName = weatherData['name'];
    });
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate(_currentLocale).then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
        Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text('LiveStock',style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.bold

                ),),
                IconButton(icon: Image.asset('lib/assets/images/bank.png'),color: Colors.black,onPressed: (){},)

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      temperature == null ? '': '$temperature°',
                      style: kTempTextStyle,
                    ),

                    Text(
                      areaName == null ? '' : '(In $areaName )',
                      style: kMessageTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Weather',style: GoogleFonts.poppins(
                      fontSize: 20,


                    ),),
                    IconButton(icon: Image.asset('lib/assets/images/moon.png'),color: Colors.black,onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (c)=> LocationScreen()));
                    },)
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2.0,
                color: Colors.black,
              ),
            ),
            Column(
              children: [
                Text('Diseases',style: GoogleFonts.poppins(
                  fontSize: 26,
                  color: Colors.red,
                ),),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (c)=> DiesesInformation()));

                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: 100,
                    width: 100,
                    child:  ClipRRect(
                      child: Image.asset('lib/assets/images/dieses.jpeg'),
                      borderRadius: BorderRadius.circular(20),


                    ),
                  ),
                )

              ],
            ),
            SizedBox(height: 25,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2.0,
                color: Colors.black,
              ),
            ),

            Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          height: 100,
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey.shade200,
                          child: Text(transcription)),
                      _buildButton(
                        onPressed:()
                        {

                          if(_speechRecognitionAvailable && !_isListening)
                            {
                              start();
                            }

                        }


                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> InformationMaangemt()));
              },
              child:  Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black12,

                  ),

                  child: Text('Information Management',style: GoogleFonts.poppins(
                      fontSize:28,
                      color: Colors.red

                  ),),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => CheckedPopupMenuItem<Language>(
    value: l,
    checked: selectedLang == l,
    child: Text(l.name),
  ))
      .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }


  Widget _buildButton({VoidCallback? onPressed}) => Padding(
      padding: EdgeInsets.all(12.0),
      child: IconButton(
        iconSize: 70,
        onPressed: onPressed, icon: Image.asset('lib/assets/images/cow.png'),

      ));

  void start() => _speech.activate(selectedLang.code).then((_) {
    return _speech.listen().then((result) {
      print('_MyAppState.start => result $result');
      setState(() {
        _isListening = result;
      });
    });
  });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stop() => _speech.stop().then((_) {
    setState(() => _isListening = false);
  });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
            () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    Utils().toastMessage('Listening....',Colors.green);
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() => transcription = text);
  }

  void onRecognitionComplete(String text) {
    Utils().toastMessage('Completed....',Colors.green);
    print('_MyAppState.onRecognitionComplete... $text');

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchWidget(search: transcription,)));
    setState(() => _isListening = false);
  }

  void errorHandler() => activateSpeechRecognizer();
}