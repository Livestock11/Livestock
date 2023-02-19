import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:livestock/utils.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ReadPDF extends StatefulWidget {
  final String path;
  final String name;
  const ReadPDF({Key? key, required this.path, required this.name})
      : super(key: key);

  @override
  State<ReadPDF> createState() => _ReadPDFState();
}

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

const languages = const [
  const Language('Urdu', 'ur_PK'),
];

class _ReadPDFState extends State<ReadPDF> {
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;
  TextEditingController controller = TextEditingController();
  late SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  String _currentLocale = 'ur_PK';
  Language selectedLang = languages.first;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    activateSpeechRecognizer();
    super.initState();
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
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.name,
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Visibility(
              visible: _searchResult.hasResult,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
                onPressed: () {
                  _searchResult.previousInstance();
                },
              ),
            ),
            Visibility(
              visible: _searchResult.hasResult,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: () {
                  _searchResult.nextInstance();
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                onChanged: (value) {
                  _searchResult = _pdfViewerController.searchText(
                    // value,
                      String.fromCharCodes(utf8.encode(value)),  // atif changed
                    searchOption: TextSearchOption.caseSensitive,
                  );
                  // String searchQuery = 'ایک';
                  // _pdfViewerController.searchText(utf8.encode(searchQuery));
                  if (kIsWeb) {
                    setState(() {});
                  } else {
                    _searchResult.addListener(() {
                      if (_searchResult.hasResult) {
                        setState(() {});
                      }
                    });
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    icon: IconButton(
                        onPressed: _speechRecognitionAvailable && !_isListening
                            ? () => start()
                            : null,
                        icon: Icon(Icons.search)),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Type in your text",
                    fillColor: Colors.white70),
              ),
              Container(
                height: height * 0.75,
                child: SfPdfViewer.network(
                  widget.path,
                  controller: _pdfViewerController,
                ),
              ),
            ],
          ),
        ));
  }

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
    Utils().toastMessage('Listening....', Colors.green);
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() {
      transcription = text;
      controller.text = transcription;
    });
  }

  void onRecognitionComplete(String text) {
    Utils().toastMessage('Completed....', Colors.green);
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void errorHandler() => activateSpeechRecognizer();
}
