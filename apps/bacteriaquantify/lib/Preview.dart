import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bacteriaquantify/Dashboard.dart';
import 'package:bacteriaquantify/services/UserService.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/widgets/BigRoundButton.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconButton.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;
import 'package:image_picker/image_picker.dart';
import 'package:extended_image/extended_image.dart';

import 'package:oktoast/oktoast.dart';
import 'auth_screen.dart';
import 'models/User.dart';

class Preview extends StatefulWidget {
  bool showImagePicker = true;
  Preview({required this.showImagePicker});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  final usernameCtr = TextEditingController();

  bool showBrightness = false;
  bool showContrast = false;
  bool showSaturation = false;

  bool isLoading = false;
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey();

  ImageProvider provider = ExtendedExactAssetImageProvider(
    'assets/home_24px.png',
    cacheRawData: true,
  );

  @override
  void initState() {
    super.initState();
    if (widget.showImagePicker) {
      _pick();
    }
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                //top nav
                width: size!.width * 0.9,

                height: 50,
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 40.0, top: 10, bottom: 10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Dashboard()));
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
              Container(
                  width: size!.width * 0.9,
                  //padding: EdgeInsets.only(top: 80, bottom: 60.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /*AspectRatio(
                          aspectRatio: 1,
                          child: buildImage(),
                        ),*/
                        buildImage(),
                        const SizedBox(height: 44),
                        BigRoundIconButton(
                            onTap: () async {
                              print("insert photo");
                              _pick();
                            },
                            icon: const AssetImage(
                                "assets/add_photo_alternate_24px.png"),
                            title: "Insert Photo"),
                        Column(
                          children: <Widget>[
                            showBrightness
                                ? _buildBrightness()
                                : const SizedBox(),
                            showContrast ? _buildCon() : const SizedBox(),
                            showSaturation ? _buildSat() : const SizedBox(),
                          ],
                        ),
                        Container(
                          width: size!.width * 0.8,
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    image:
                                        AssetImage("assets/wb_sunny_24px.png")),
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
                                    image: AssetImage("assets/iso_24px.png")),
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
                          width: size!.width * 0.8,
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 10, bottom: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                },
                                title: "Take a Photo"))
                      ])),
            ]))
      ]),
    ));
  }

  Widget buildImage() {
    return ExtendedImage(
      image: provider,
      height: 400,
      width: 400,
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

  Future<void> _pick() async {
    print("pick1");
    final XFile? result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
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
    setState(() {});
  }

  double sat = 1;
  double bright = 1;
  double con = 1;

  Widget _buildSat() {
    return Slider(
      label: 'sat : ${sat.toStringAsFixed(2)}',
      onChanged: (double value) {
        setState(() {
          sat = value;
        });
      },
      value: sat,
      min: 0,
      max: 2,
    );
  }

  Widget _buildBrightness() {
    return Slider(
      label: 'brightness : ${bright.toStringAsFixed(2)}',
      onChanged: (double value) {
        setState(() {
          bright = value;
        });
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
        setState(() {
          con = value;
        });
      },
      value: con,
      min: 0,
      max: 4,
    );
  }

  Future<void> crop([bool test = false]) async {
    final ExtendedImageEditorState? state = editorKey.currentState;
    if (state == null) {
      return;
    }
    final Rect? rect = state.getCropRect();
    if (rect == null) {
      showToast('The crop rect is null.');
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

    final ImageEditorOption option = ImageEditorOption();

    option.addOption(ClipOption.fromRect(rect));
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    if (action.hasRotateAngle) {
      option.addOption(RotateOption(radian.toInt()));
    }

    option.addOption(ColorOption.saturation(sat));
    option.addOption(ColorOption.brightness(bright));
    option.addOption(ColorOption.contrast(con));

    option.outputFormat = const OutputFormat.png(88);

    print(const JsonEncoder.withIndent('  ').convert(option.toJson()));

    final DateTime start = DateTime.now();
    final Uint8List? result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );

    print('result.length = ${result?.length}');

    final Duration diff = DateTime.now().difference(start);

    print('image_editor time : $diff');
    showToast('handle duration: $diff',
        duration: const Duration(seconds: 5), dismissOtherToast: true);

    if (result == null) return;

    showPreviewDialog(result);
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
}
