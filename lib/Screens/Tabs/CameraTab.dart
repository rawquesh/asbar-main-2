import 'dart:io';

import 'package:asbar/Constants/colors.dart';
import 'package:asbar/Widgets/smallText.dart';
import 'package:asbar/models/filter.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:googleapis/classroom/v1.dart';
// import 'package:googleapis/transcoder/v1.dart';
import 'package:open_file/open_file.dart';

import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../Constants/values.dart';
import '../../Providers/MainProvider.dart';

DeepArConfig config = const DeepArConfig(
  androidKey: kAndroidKey,
  ioskey: kIosKey,
  displayMode: DisplayMode.camera,
);

class CameraTab extends StatefulWidget {
  const CameraTab({Key? key}) : super(key: key);

  @override
  State<CameraTab> createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  final _controller = CameraDeepArController(config);
  String version = '';
  // bool _isFaceMask = false;
  // bool _isFilter = false;
  bool _isEffectApplied = false;

  final List<Filter> _effectsList = [];
  final List<String> _maskList = [];
  final List<String> _filterList = [];
  int _effectIndex = 0;
  int _maskIndex = 0;
  int _filterIndex = 0;
  double value = 1.5;
  double value2 = 0;

  final String _assetEffectsPath = 'assets/neweffects/';

  CameraMode cameraMode = config.cameraMode;
  DisplayMode displayMode = config.displayMode;

  @override
  void initState() {
    super.initState();

    CameraDeepArController.checkPermissions();
    _controller.setEventHandler(DeepArEventHandler(onCameraReady: (v) {
      setState(() {});
    }, onSnapPhotoCompleted: (v) {
      OpenFile.open(v);

      setState(() {});
    }, onVideoRecordingComplete: (v) {
      setState(() {});
    }, onSwitchEffect: (v) {
      setState(() {});
    }));
  }

  @override
  void didChangeDependencies() {
    _initEffects();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DeepArPreview(_controller),
          _topMediaOptions(),
          _bottomMediaOptions(),
        ],
      ),
    );
  }

  Positioned _topMediaOptions() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () async {
                await _controller.switchCamera();

                // await _controller.toggleFlash();
                setState(() {});
              },
              color: Colors.white70,
              iconSize: 40,
              icon: const Icon(Icons.flip_camera_ios_outlined),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Opacity(
                opacity: .5,
                child: Image.asset(
                  'assets/asbar.png',
                  height: 2.2.h,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // _controller.flipCamera();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomDropDown(
                    handler: (int index) {
                      setState(() {
                        _effectIndex = index;
                        print(_effectsList[index].path);
                        _controller.switchEffect(cameraMode, _effectsList[index].path);
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                    child: SfSliderTheme(
                      data: SfSliderTheme.of(context).copyWith(
                          activeLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          inactiveLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          )),
                      child: SfSlider.vertical(
                          // showLabels: true,

                          stepSize: 1,
                          min: _effectsList[_effectIndex].min,
                          max: _effectsList[_effectIndex].max,
                          interval: 1,
                          activeColor: kBlue2,
                          // isInversed: true,
                          value: value,
                          onChanged: (val) async {
                            _controller.changeParameterFloat(
                              _effectsList[_effectIndex].gameObject,
                              _effectsList[_effectIndex].component,
                              _effectsList[_effectIndex].parameter,
                              val,
                            );
                            setState(() {
                              value = val;
                            });
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // prev, record, screenshot, next
  /// Sample option which can be performed
  Positioned _bottomMediaOptions() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // if (_effectIndex == 0)
            //   SizedBox(
            //     width: 70.w,
            //     height: 5.h,
            //     child: SfSliderTheme(
            //       data: SfSliderTheme.of(context).copyWith(
            //           activeLabelStyle: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 12,
            //             fontStyle: FontStyle.italic,
            //           ),
            //           inactiveLabelStyle: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 12,
            //             fontStyle: FontStyle.italic,
            //           )),
            //       child: SfSlider(
            //           stepSize: 1,
            //           min: 0,
            //           max: 40,
            //           interval: 1,
            //           // isInversed: true,
            //           value: value2,
            //           onChanged: (val) async {
            //             _controller.changeParameter(
            //                 gameObject: 'Mesh.001',
            //                 component: _effectsList[_effectIndex].component,
            //                 parameter: 'jaw',
            //                 newParameter: val);
            //             setState(() {
            //               value2 = val;
            //             });
            //           }),
            //     ),
            //   ),
            // if (_isEffectApplied)
            //   Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 6.w),
            //     child: Row(
            //       children: [
            //         IconButton(
            //             iconSize: 60,
            //             onPressed: () {
            //               setState(() {
            //                 String path = _getPrevEffect();

            //                 _controller.switchFilter(path);
            //               });
            //             },
            //             icon: const Icon(
            //               Icons.arrow_back_ios,
            //               color: Colors.white70,
            //             )),
            //         const Spacer(),
            //         Text(
            //           _effectsList[_effectIndex].name,
            //           style: const TextStyle(fontSize: 20, color: Colors.white),
            //         ),
            //         const Spacer(),
            //         IconButton(
            //             iconSize: 60,
            //             onPressed: () {
            //               setState(() {
            //                 String path = _getNextEffect();
            //                 _controller.switchFilter(path);
            //               });
            //             },
            //             icon: const Icon(
            //               Icons.arrow_forward_ios,
            //               color: Colors.white70,
            //             )),
            //       ],
            //     ),
            //   ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () async {
                      // _controller.changeParameter(
                      //     gameObject: gameObject,
                      //     component: component,
                      //     parameter: parameter);
                      MainProvider mainProviderFalse = Provider.of<MainProvider>(context, listen: false);
                      // if (_controller.isRecording) {
                      //   File? file = await _controller.stopVideoRecording();
                      //   OpenFile.open(file.path);
                      // } else {
                      //   await _controller.startVideoRecording();
                      // }

                      // setState(() {});
                      mainProviderFalse.changeBottomTabIndex(0);
                    },
                    iconSize: 50,
                    color: Colors.white70,
                    icon: SvgPicture.asset(
                      'assets/svgs/feed.svg',
                      height: 4.h,
                    )),
                // const SizedBox(width: 20),

                IconButton(
                  iconSize: 60,
                  onPressed: () {
                    if (_isEffectApplied) {
                      _controller.snapPhoto().then((imagePath) {
                        // print(file);
                      });
                    } else {
                      String nextEffect = _effectsList[0].path;

                      _controller.switchEffect(cameraMode, nextEffect);
                    }
                    setState(() {
                      _isEffectApplied = true;
                    });
                  },
                  icon: SvgPicture.asset('assets/svgs/camera.svg'),
                ),
                IconButton(
                    onPressed: () {
                      // _controller.takeScreenshot().then((file) {
                      //   OpenFile.open(file.path);
                      // });
                      MainProvider mainProviderFalse = Provider.of<MainProvider>(context, listen: false);

                      mainProviderFalse.changeBottomTabIndex(2);
                    },
                    color: Colors.white70,
                    iconSize: 40,
                    icon: SvgPicture.asset(
                      'assets/svgs/gallery.svg',
                      height: 4.h,
                      color: Colors.white70,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Add effects which are rendered via DeepAR sdk
  void _initEffects() {
    _effectsList.clear();

    _effectsList.add(Filter(
      name: 'modifiedlips',
      path: '${_assetEffectsPath}modifiedlips.deepar',
      min: 0,
      max: 60,
      gameObject: 'Mesh',
      parameter: 'Natural',
    ));
    _effectsList.add(Filter(
      name: 'modifiedlips',
      path: '${_assetEffectsPath}modifiedlips.deepar',
      min: 0,
      max: 60,
      gameObject: 'Mesh',
      parameter: 'Pointy natural',
    ));
    _effectsList.add(Filter(
      name: 'modifiedlips',
      path: '${_assetEffectsPath}modifiedlips.deepar',
      min: 0,
      max: 60,
      gameObject: 'Mesh',
      parameter: "Cupid's bow",
    ));
    _effectsList.add(Filter(
      name: 'modifiedlips',
      path: '${_assetEffectsPath}modifiedlips.deepar',
      min: 0,
      max: 60,
      gameObject: 'Mesh',
      parameter: 'Uni-lip',
    ));
    _effectsList.add(Filter(
      name: 'modifiedlips',
      path: '${_assetEffectsPath}modifiedlips.deepar',
      min: 0,
      max: 60,
      gameObject: 'Mesh',
      parameter: 'Beestung',
    ));
    _effectsList.add(Filter(
      name: 'modifiedlips',
      path: '${_assetEffectsPath}modifiedlips.deepar',
      min: 0,
      max: 60,
      gameObject: 'Mesh',
      parameter: 'Smear',
    ));
    _effectsList.add(Filter(
      name: 'modifiedlips',
      path: '${_assetEffectsPath}modifiedlips.deepar',
      min: 0,
      max: 60,
      gameObject: 'Mesh',
      parameter: 'Glamour',
    ));
    _effectsList.add(Filter(
      name: 'chin',
      path: '${_assetEffectsPath}chin.deepar',
      min: 0,
      max: 40,
      gameObject: 'Mesh.001',
      parameter: 'jaw',
    ));

    _effectsList.add(Filter(
      name: 'modifiedcheeks',
      path: '${_assetEffectsPath}modifiedcheeks.deepar',
      min: 0,
      max: 60,
      gameObject: 'Mesh',
      parameter: 'Key 1',
    ));
    _effectsList.add(Filter(
      name: 'modifiedcheeks',
      path: '${_assetEffectsPath}modifiedcheeks.deepar',
      min: 0,
      max: 80,
      gameObject: 'Mesh',
      parameter: 'Key 2',
    ));

    _effectsList.add(Filter(
      name: 'jaw2chin',
      path: '${_assetEffectsPath}jaw2chin.deepar',
      min: 0,
      max: 40,
      gameObject: 'Mesh.006',
      parameter: 'jaw',
    ));
    _effectsList.add(Filter(
      name: 'chin2',
      path: '${_assetEffectsPath}chin2.deepar',
      min: 0,
      max: 40,
      gameObject: 'Mesh.001',
      parameter: 'jaw',
    ));

    _effectsList.add(Filter(
      name: 'temple',
      path: '${_assetEffectsPath}temple.deepar',
      min: 0,
      max: 40,
      gameObject: 'Temple',
      parameter: 'Temple',
    ));
    // _effectsList.add(Filter(
    //   name: 'modifiedcheeks',
    //   path: '${_assetEffectsPath}modifiedcheeks.deepar',
    //   min: 0,
    //   max: 60,
    //   gameObject: 'Mesh',
    //   parameter: 'Key 1',
    // ));
    // _effectsList.add(Filter(
    //   name: 'Temple',
    //   path: '${_assetEffectsPath}temple.deepar',
    //   min: 0,
    //   max: 50,
    //   gameObject: 'Mesh.001',
    //   parameter: 'temple',
    // ));

    // _effectsList.add(_assetEffectsPath+'flower_face.deepar');
    // _effectsList.add(_assetEffectsPath+'Hope.deepar');
    // _effectsList.add(_assetEffectsPath+'viking_helmet.deepar');
    print(_effectsList.length);
  }

  /// Get all deepar effects from assets
  ///
  Future<List<String>> _getEffectsFromAssets(BuildContext context) async {
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final filePaths = manifestMap.keys.where((path) => path.startsWith(_assetEffectsPath)).toList();
    return filePaths;
  }

  /// Get next effect
  String _getNextEffect() {
    _effectIndex < _effectsList.length ? _effectIndex++ : _effectIndex = 0;
    return _effectsList[_effectIndex].path;
  }

  /// Get previous effect
  String _getPrevEffect() {
    _effectIndex > 0 ? _effectIndex-- : _effectIndex = _effectsList.length;
    return _effectsList[_effectIndex].path;
  }

  /// Get next mask
  String _getNextMask() {
    _maskIndex < _maskList.length ? _maskIndex++ : _maskIndex = 0;
    return _maskList[_maskIndex];
  }

  /// Get previous mask
  String _getPrevMask() {
    _maskIndex > 0 ? _maskIndex-- : _maskIndex = _maskList.length;
    return _maskList[_maskIndex];
  }

  /// Get next filter
  String _getNextFilter() {
    _filterIndex < _filterList.length ? _filterIndex++ : _filterIndex = 0;
    return _filterList[_filterIndex];
  }

  /// Get previous filter
  String _getPrevFilter() {
    _filterIndex > 0 ? _filterIndex-- : _filterIndex = _filterList.length;
    return _filterList[_filterIndex];
  }
}

class CustomDropDown extends StatefulWidget {
  final Function(int index) handler;
  const CustomDropDown({
    Key? key,
    required this.handler,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  int index = -1;
  int subIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15.w,
          height: 50.h,
          padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: Colors.white70,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CircularItem(
                isSelected: index == 0,
                onTap: () {
                  if (index == 0) {
                    setState(() {
                      index = -1;
                    });
                  } else {
                    setState(() {
                      index = 0;
                    });
                  }

                  // widget.handler(subIndex);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: index != 0 ? Colors.white : kBlue1,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Image.asset(
                      'assets/images/1.jpg',
                      // color: index == 0 ? Colors.white : kBlue1,
                      // height: 25,
                    ),
                  ),
                ),
              ),
              _CircularItem(
                isSelected: index == 1,
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                  widget.handler(7);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: index != 1 ? Colors.white : kBlue1,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Image.asset(
                      'assets/images/2.jpg',
                      // color: index == 0 ? Colors.white : kBlue1,
                      // height: 25,
                    ),
                  ),
                ),
              ),
              _CircularItem(
                isSelected: index == 2,
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                  // widget.handler(8);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: index != 2 ? Colors.white : kBlue1,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Image.asset(
                      'assets/images/3.jpg',
                      // color: index == 0 ? Colors.white : kBlue1,
                      // height: 25,
                    ),
                  ),
                ),
              ),
              _CircularItem(
                isSelected: index == 3,
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                  widget.handler(10);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: index != 3 ? Colors.white : kBlue1,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Image.asset(
                      'assets/images/4.jpg',
                      // color: index == 0 ? Colors.white : kBlue1,
                      // height: 25,
                    ),
                  ),
                ),
              ),
              _CircularItem(
                isSelected: index == 4,
                onTap: () {
                  setState(() {
                    index = 4;
                  });
                  widget.handler(11);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: index != 4 ? Colors.white : kBlue1,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Image.asset(
                      'assets/images/5.jpg',
                      // color: index == 0 ? Colors.white : kBlue1,
                      // height: 25,
                    ),
                  ),
                ),
              ),
              _CircularItem(
                isSelected: index == 5,
                onTap: () {
                  setState(() {
                    index = 5;
                  });
                  widget.handler(12);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: index != 5 ? Colors.white : kBlue1,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Image.asset(
                      'assets/images/6.jpg',
                      // color: index == 0 ? Colors.white : kBlue1,
                      // height: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        //TODO lkj

        if (index != -1)
          Container(
            width: 15.w,
            // height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              color: Colors.white70,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (index == 0) ...[
                  _CircularItem(
                    isSelected: subIndex == 0,
                    onTap: () {
                      setState(() {
                        subIndex = 0;
                      });
                      widget.handler(subIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 0 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/3.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                  _CircularItem(
                    isSelected: subIndex == 1,
                    onTap: () {
                      setState(() {
                        subIndex = 1;
                      });
                      widget.handler(subIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 1 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/4.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                  _CircularItem(
                    isSelected: subIndex == 2,
                    onTap: () {
                      setState(() {
                        subIndex = 2;
                      });
                      widget.handler(subIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 2 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/5.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                  _CircularItem(
                    isSelected: subIndex == 3,
                    onTap: () {
                      setState(() {
                        subIndex = 3;
                      });
                      widget.handler(subIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 3 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/6.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                  _CircularItem(
                    isSelected: subIndex == 4,
                    onTap: () {
                      setState(() {
                        subIndex = 4;
                      });
                      widget.handler(subIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 4 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/7.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                  _CircularItem(
                    isSelected: subIndex == 5,
                    onTap: () {
                      setState(() {
                        subIndex = 5;
                      });
                      widget.handler(subIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 5 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/8.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                  _CircularItem(
                    isSelected: subIndex == 6,
                    onTap: () {
                      setState(() {
                        subIndex = 6;
                      });
                      widget.handler(subIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 6 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/9.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                ],
                if (index == 2) ...[
                  _CircularItem(
                    isSelected: subIndex == 7,
                    onTap: () {
                      setState(() {
                        subIndex = 7;
                      });
                      widget.handler(8);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 7 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/1.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                  _CircularItem(
                    isSelected: subIndex == 8,
                    onTap: () {
                      setState(() {
                        subIndex = 8;
                      });
                      widget.handler(9);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subIndex != 8 ? Colors.white : kBlue1,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: Image.asset(
                          'assets/cheeks/2.jpg',
                          // color: index == 0 ? Colors.white : kBlue1,
                          // height: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _CircularItem extends StatelessWidget {
  final Function() onTap;

  const _CircularItem({
    Key? key,
    required this.isSelected,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(backgroundColor: isSelected ? Colors.blue : Colors.white, radius: 3.5.h, child: child),
    );
  }
}
