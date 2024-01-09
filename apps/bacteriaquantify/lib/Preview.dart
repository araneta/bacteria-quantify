import 'dart:convert';
import 'dart:io';
import 'package:bacteriaquantify/models/DetectionResultResponse.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as imgLib;

import 'package:path/path.dart' as Path;
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:bacteriaquantify/Dashboard.dart';
import 'package:bacteriaquantify/services/UserService.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/widgets/BigRoundButton.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconTextButton.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;
import 'package:image_picker/image_picker.dart';
import 'package:extended_image/extended_image.dart';
import 'package:bacteriaquantify/utils/Media.dart';
import 'package:bacteriaquantify/utils/MultipartRequest.dart';
import 'package:oktoast/oktoast.dart';
import 'Config.dart';
import 'Result.dart';
import 'auth_screen.dart';
import 'models/DetectionResult.dart';
import 'models/User.dart';

class Preview extends StatefulWidget {
  int source = 1; //1:camera, 2: gallery
  Preview({required this.source});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  ImageProvider provider = ExtendedExactAssetImageProvider(
    'assets/home_24px.png',
    cacheRawData: true,
  );

  final usernameCtr = TextEditingController();
  String imageID = "";
  bool showBrightness = false;
  bool showContrast = false;
  bool showSaturation = false;
  bool isDone = false;
  bool isButtonDisabled = true;
  double _progressValue = 0;
  int _progressPercentValue = 0;
  bool isLoading = false;
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey();
  String localFileURL = "";
  //return from server
  String fileurl = "";
  Uint8List? bytes;
  double sat = 1;
  double bright = 1;
  double con = 100;
  imgLib.Image? _image;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _image = imgLib.Image(width: 250, height: 250);
    _imageBytes = imgLib.encodeJpg(_image!);

    _pick(widget.source);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    User user = UserPreferences.getUser();

    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //top nav
                    width: size!.width * 0.9,

                    height: 50,
                    child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Dashboard()),
                                  );
                                }, // Image tapped
                                child: const Image(
                                    width: 30,
                                    height: 30,
                                    image: AssetImage(
                                        "assets/arrow_back_ios_24px.png")),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Text(
                                    "Preview",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                        color: textBlue),
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Dashboard()));
                                }, // Image tapped
                                child: const Image(
                                    width: 30,
                                    height: 30,
                                    image: AssetImage(
                                        "assets/home_24px_outlined.png")),
                              ),
                            ])),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: size!.width * 0.9,
                      //padding: EdgeInsets.only(top: 80, bottom: 60.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /*AspectRatio(
                          aspectRatio: 1,
                          child: buildImage(),
                        ),*/
                            buildImage(),
                            const SizedBox(height: 24),
                            SliderTheme(
                                data: SliderThemeData(
                                    showValueIndicator:
                                        ShowValueIndicator.onlyForContinuous),
                                child: Column(
                                  children: <Widget>[
                                    showBrightness
                                        ? _buildBrightness()
                                        : const SizedBox(),
                                    showContrast
                                        ? _buildCon()
                                        : const SizedBox(),
                                    showSaturation
                                        ? _buildSat()
                                        : const SizedBox(),
                                  ],
                                )),
                            Container(
                              //width: size!.width * 0.8,
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('brightness');
                                      setState(() {
                                        showBrightness = !showBrightness;
                                        showContrast = false;
                                        showSaturation = false;
                                      });
                                    }, // Image tapped
                                    child: const Image(
                                        width: 30,
                                        height: 30,
                                        image: AssetImage(
                                            "assets/wb_sunny_24px.png")),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('contrast');
                                      setState(() {
                                        showBrightness = false;
                                        showContrast = !showContrast;
                                        showSaturation = false;
                                      });
                                    }, // Image tapped
                                    child: const Image(
                                        width: 30,
                                        height: 30,
                                        image:
                                            AssetImage("assets/iso_24px.png")),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('saturation');
                                      setState(() {
                                        showBrightness = false;
                                        showContrast = false;
                                        showSaturation = !showSaturation;
                                      });
                                    }, // Image tapped
                                    child: const Image(
                                        width: 30,
                                        height: 30,
                                        image: AssetImage(
                                            "assets/invert_colors_24px_outlined.png")),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              //width: size!.width * 0.8,
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30, top: 10, bottom: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('flip');
                                      flip();
                                    }, // Image tapped
                                    child: const Image(
                                        width: 30,
                                        height: 30,
                                        image: AssetImage(
                                            "assets/flip_24px_outlined.png")),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('rotate');
                                      rotate(false);
                                    }, // Image tapped
                                    child: const Image(
                                        width: 30,
                                        height: 30,
                                        image: AssetImage(
                                            "assets/rotate_left_24px_outlined.png")),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      print('crop');
                                      await crop();
                                    }, // Image tapped
                                    child: const Image(
                                        width: 30,
                                        height: 30,
                                        image: AssetImage(
                                            "assets/crop_24px_outlined.png")),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                width: size!.width * 0.6,
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30, top: 10, bottom: 50),
                                child: BigRoundButton(
                                    onTap: () async {
                                      print("calculate");

                                      if (isDone) {
                                        print("calculatex1");
                                        Navigator.of(context).pop();
                                      } else {
                                        print("calculatex2");
                                        if (!isButtonDisabled) {
                                          print("calculatex4");
                                          uploadImageWithHttp()!;
                                        }
                                      }
                                    },
                                    title: "Calculate"))
                          ])),
                ]))
      ]),
    ));
  }

  Widget buildImage() {
    return ExtendedImage.memory(
      _imageBytes!,
      height: 320,
      width: 320,
      extendedImageEditorKey: editorKey,
      mode: ExtendedImageMode.editor,
      fit: BoxFit.contain,
      initEditorConfigHandler: (_) => EditorConfig(
        maxScale: 8.0,
        //cropRectPadding: const EdgeInsets.all(20.0),
        hitTestSize: 20.0,
        //cropAspectRatio: 2 / 1,
      ),
    );
    return ExtendedImage(
      image: provider,
      height: 320,
      width: 320,
      extendedImageEditorKey: editorKey,
      mode: ExtendedImageMode.editor,
      fit: BoxFit.contain,
      initEditorConfigHandler: (_) => EditorConfig(
        maxScale: 8.0,
        //cropRectPadding: const EdgeInsets.all(20.0),
        hitTestSize: 20.0,
        //cropAspectRatio: 2 / 1,
      ),
    );
  }

  Future<void> _pick(int source) async {
    print("pick1");
    final XFile? result = await ImagePicker().pickImage(
      source: source == 1 ? ImageSource.camera : ImageSource.gallery,
    );
    print("pick2");
    if (result == null) {
      showToast('The pick file is null');
      return;
    }
    print("pick3");
    print(result.path);
    dynamic file = File(result.path);
    print("pick4");
    provider = FileImage(file);

    print("pick5");
    provider = ExtendedFileImageProvider(File(result.path), cacheRawData: true);
    Uint8List bytes = file.readAsBytesSync();
    ByteBuffer buffer = bytes.buffer;
    //print(bytes);

    setState(() {
      isButtonDisabled = false;
      localFileURL = result.path;
      //
      _imageBytes = bytes;
      _image = imgLib.decodeImage(bytes);
    });
  }

  void changeBCS(int mode, double val) async {
    print("changeSaturation");

    // final img = await getImageFromEditorKey(editorKey);
//https://cbtdev.net/dart-image-library/
    try {
      var image = _image!.clone();
      print(mode);
      print(val);
      if (mode == 2) {
        image = imgLib.contrast(image!, contrast: val);
      } else if (mode == 1) {
        image = imgLib.adjustColor(image!, brightness: val);
      } else if (mode == 3) {
        image = imgLib.adjustColor(image!, saturation: val);
      }

      print("xx5");
      setState(() {
        _imageBytes = imgLib.encodeJpg(image);
        //_image = image;
      });
      print("xx7");
    } catch (ex) {
      print(ex);
    }
  }

  Widget _buildSat() {
    return Slider(
      label: 'sat : ${sat.toStringAsFixed(2)}',
      onChanged: (double value) {
        //print(value);
        setState(() {
          sat = value;
        });
      },
      onChangeEnd: (double newValue) {
        changeBCS(3, newValue);
      },
      value: sat,
      min: -2,
      max: 4,
    );
  }

  Widget _buildBrightness() {
    return Slider(
      label: 'brightness : ${bright.toStringAsFixed(2)}',
      onChanged: (double value) {
        //print(value);
        setState(() {
          bright = value;
        });
      },
      onChangeEnd: (double newValue) {
        changeBCS(1, newValue);
      },
      value: bright,
      min: 0,
      max: 2,
    );
  }

  Widget _buildCon() {
    return Slider(
      label: 'con : ${con.toStringAsFixed(2)}',
      onChanged: (double value) {
        //print(value);
        setState(() {
          con = value;
        });
      },
      onChangeEnd: (double newValue) {
        changeBCS(2, newValue);
      },
      value: con,
      min: 0,
      max: 200,
    );
  }

  Future<void> crop([bool test = false]) async {
    print("uuh");
    final ExtendedImageEditorState? state = editorKey.currentState;
    if (state == null) {
      return;
    }
    final Rect? rect = state.getCropRect();
    if (rect == null) {
      print('The crop rect is null.');
      return;
    }
    final EditActionDetails action = state.editAction!;
    final double radian = action.rotateAngle;

    final bool flipHorizontal = action.flipY;
    final bool flipVertical = action.flipX;
    // final img = await getImageFromEditorKey(editorKey);
    final Uint8List? img = state.rawImageData;

    if (img == null) {
      showToast('The img is null.');
      return;
    }

    //final ImageEditorOption option = ImageEditorOption();

    //option.addOption(ClipOption.fromRect(rect));
    //option.addOption(
    //FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    //if (action.hasRotateAngle) {
    //option.addOption(RotateOption(radian.toInt()));
    //}
/*
    option.addOption(ColorOption.saturation(sat));
    option.addOption(ColorOption.brightness(bright));
    option.addOption(ColorOption.contrast(con));
*/
    //option.outputFormat = const OutputFormat.png(88);

    //print(const JsonEncoder.withIndent('  ').convert(option.toJson()));
    print("uuh1");
    final DateTime start = DateTime.now();
    print("uuh2");
    try {
      /*
      final Uint8List? result = await ImageEditor.editImage(
        image: img,
        imageEditorOption: option,
      );*/
      if (action.needCrop) {
        var image = _image!.clone();
        var result = imgLib.copyCrop(image,
            x: rect.left.toInt(),
            y: rect.top.toInt(),
            width: rect.width.toInt(),
            height: rect.height.toInt());

        print("uuh3");
        print('result.length = ${result?.length}');

        final Duration diff = DateTime.now().difference(start);

        print('image_editor time : $diff');

        print("uuh4");
        if (result == null) return;
        print("uuh5");
        setState(() {
          //_image = result;
          _imageBytes = imgLib.encodeJpg(result!);
        });
        print("uuh6");
        showPreviewDialog(result.buffer.asUint8List());
      }
    } catch (ex) {
      print(ex);
    }
  }

  void flip() {
    editorKey.currentState?.flip();
  }

  void rotate(bool right) {
    editorKey.currentState?.rotate(right: right);
  }

  void showPreviewDialog(Uint8List image) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          child: Center(
            child: SizedBox.fromSize(
              size: const Size.square(200),
              child: Container(
                child: Image.memory(image),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double remap(double value, double originalMinValue, double originalMaxValue,
      double translatedMinValue, double translatedMaxValue) {
    if (originalMaxValue - originalMinValue == 0) return 0;

    return (value - originalMinValue) /
            (originalMaxValue - originalMinValue) *
            (translatedMaxValue - translatedMinValue) +
        translatedMinValue;
  }

  void _setUploadProgress(int sentBytes, int totalBytes) {
    double __progressValue =
        remap(sentBytes.toDouble(), 0, totalBytes.toDouble(), 0, 1);

    __progressValue = double.parse(__progressValue.toStringAsFixed(2));

    if (__progressValue != _progressValue)
      setState(() {
        _progressValue = __progressValue;
        _progressPercentValue = (_progressValue * 100.0).toInt();
      });
  }

  uploadImageWithHttp() async {
    final ExtendedImageEditorState? state = editorKey.currentState;
    if (state == null) {
      return;
    }
    print("uploadImageWithHttp");
    User user = UserPreferences.getUser();
    final url = '${Config.API_HOST}/api/upload-detect';
    setState(() {
      imageID = "";
      isDone = false;
      isButtonDisabled = true;
    });
    _setUploadProgress(0, 0);
    try {
      final request = MultipartRequest2(
        'POST',
        Uri.parse(url),
        onProgress: (int bytes, int total) {
          final progress = bytes / total;
          print('progress: $progress ($bytes/$total)');
          setState(() {
            _progressValue = progress;
            _progressPercentValue = (progress * 100.0).toInt();
          });
        },
      );

      request.headers['Authorization'] = "Bearer ${user.token}";
      request.fields['form_key'] = 'form_value';
      print("uploadImageWithHttp");

      request.files.add(
        /*await http.MultipartFile.fromPath(
          'file',
          localFileURL,
          contentType: MediaType('image', 'jpeg'),
        ),*/
        await http.MultipartFile.fromBytes(
          'file',
          //_imageBytes!.buffer.asUint8List(),
          state.rawImageData.buffer.asUint8List(),
          filename: 'photo.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final streamedResponse = await request.send();
      print("result");
      final respStr = await streamedResponse.stream.bytesToString();
      print(respStr);
      print("json result");
      final responseJson = json.decode(respStr);
      print(responseJson);
      var detectionResultResponse =
          DetectionResultResponse.fromJson(responseJson);

      if (detectionResultResponse.status == 1) {
        //final imageDetails = responseJson["message"];

        var id = detectionResultResponse.message!.imageID!;
        setState(() {
          imageID = id;
          fileurl = Config.API_HOST + "/userImages/" + id + ".out.jpg";
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Result(
                    detectionResult: detectionResultResponse.message!,
                  )),
        );

        //print("imageID $imageID");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseJson["message"]),
        ));
      }
    } catch (ex) {
      print(ex);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ex.toString()),
      ));
    }

    setState(() {
      isDone = true;
      isButtonDisabled = false;
    });
  }
}
