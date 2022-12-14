// import 'package:asbar/Constants/colors.dart';
// import 'package:asbar/Widgets/smallText.dart';
// import 'package:asbar/models/filter.dart';
// import 'package:flutter/material.dart';
// import 'package:deepar_flutter/deepar_flutter.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:googleapis/classroom/v1.dart';
// import 'package:googleapis/transcoder/v1.dart';
// import 'package:open_file/open_file.dart';

// import 'dart:convert';

// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';

// import '../../Providers/MainProvider.dart';

// class CameraTab extends StatefulWidget {
//   const CameraTab({Key? key}) : super(key: key);

//   @override
//   State<CameraTab> createState() => _CameraTabState();
// }

// class _CameraTabState extends State<CameraTab> {
//   late final DeepArController _controller;
//   String version = '';
//   // bool _isFaceMask = false;
//   // bool _isFilter = false;
//   bool _isEffectApplied = false;

//   final List<Filter> _effectsList = [];
//   final List<String> _maskList = [];
//   final List<String> _filterList = [];
//   int _effectIndex = 0;
//   int _maskIndex = 0;
//   int _filterIndex = 0;
//   double value = 1.5;
//   double value2 = 0;

//   final String _assetEffectsPath = 'assets/effects/';

//   @override
//   void initState() {
//     _controller = DeepArController();

//     _controller
//         .initialize(
//           androidLicenseKey:
//               "796a8243510fdb7db779a66330ed7ddf68c5cf3e73b94e5b7cd9459aac57642412afeede70eb2a66",
//           iosLicenseKey:
//               "76756ee401cdcc7326a0be4cb07e789244a32fae7ca6a2fc2c1b52943d8e7c0b923ceb935c8dcaf6",
//           resolution: Resolution.high,
//         )
//         .then((value) => setState(() {}));
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     _initEffects();
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     _controller.destroy().catchError((err) {
//       print(err);
//     });
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _controller.isInitialized
//               ? DeepArPreview(_controller)
//               : const Center(
//                   child: Text("Loading..."),
//                 ),
//           _topMediaOptions(),
//           _bottomMediaOptions(),
//         ],
//       ),
//     );
//   }

//   Positioned _topMediaOptions() {
//     return Positioned(
//       top: 10,
//       left: 0,
//       right: 0,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               onPressed: () async {
//                 await _controller.flipCamera();

//                 // await _controller.toggleFlash();
//                 // setState(() {});
//               },
//               color: Colors.white70,
//               iconSize: 40,
//               icon: const Icon(Icons.flip_camera_ios_outlined),
//             ),
//             GestureDetector(
//               onTap: () {
//                 // _controller.flipCamera();
//               },
//               child: Column(
//                 children: [
//                   CustomDropDown(
//                     handler: (int index) {
//                       setState(() {
//                         _effectIndex = index;
//                         print(_effectsList[index].path);
//                         _controller.switchFilter(_effectsList[index].path);
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: 40.h,
//                     child: SfSliderTheme(
//                       data: SfSliderTheme.of(context).copyWith(
//                           activeLabelStyle: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontStyle: FontStyle.italic,
//                           ),
//                           inactiveLabelStyle: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontStyle: FontStyle.italic,
//                           )),
//                       child: SfSlider.vertical(
//                           // showLabels: true,

//                           stepSize: 1,
//                           min: _effectsList[_effectIndex].min,
//                           max: _effectsList[_effectIndex].max,
//                           interval: 1,
//                           // isInversed: true,
//                           value: value,
//                           onChanged: (val) async {
//                             _controller.changeParameter(
//                                 gameObject:
//                                     _effectsList[_effectIndex].gameObject,
//                                 component: _effectsList[_effectIndex].component,
//                                 parameter: _effectsList[_effectIndex].parameter,
//                                 newParameter: val);
//                             setState(() {
//                               value = val;
//                             });
//                           }),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // prev, record, screenshot, next
//   /// Sample option which can be performed
//   Positioned _bottomMediaOptions() {
//     return Positioned(
//       bottom: 0,
//       right: 0,
//       left: 0,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // if (_effectIndex == 0)
//             //   SizedBox(
//             //     width: 70.w,
//             //     height: 5.h,
//             //     child: SfSliderTheme(
//             //       data: SfSliderTheme.of(context).copyWith(
//             //           activeLabelStyle: const TextStyle(
//             //             color: Colors.white,
//             //             fontSize: 12,
//             //             fontStyle: FontStyle.italic,
//             //           ),
//             //           inactiveLabelStyle: const TextStyle(
//             //             color: Colors.white,
//             //             fontSize: 12,
//             //             fontStyle: FontStyle.italic,
//             //           )),
//             //       child: SfSlider(
//             //           stepSize: 1,
//             //           min: 0,
//             //           max: 40,
//             //           interval: 1,
//             //           // isInversed: true,
//             //           value: value2,
//             //           onChanged: (val) async {
//             //             _controller.changeParameter(
//             //                 gameObject: 'Mesh.001',
//             //                 component: _effectsList[_effectIndex].component,
//             //                 parameter: 'jaw',
//             //                 newParameter: val);
//             //             setState(() {
//             //               value2 = val;
//             //             });
//             //           }),
//             //     ),
//             //   ),
//             // if (_isEffectApplied)
//             //   Padding(
//             //     padding: EdgeInsets.symmetric(horizontal: 6.w),
//             //     child: Row(
//             //       children: [
//             //         IconButton(
//             //             iconSize: 60,
//             //             onPressed: () {
//             //               setState(() {
//             //                 String path = _getPrevEffect();

//             //                 _controller.switchFilter(path);
//             //               });
//             //             },
//             //             icon: const Icon(
//             //               Icons.arrow_back_ios,
//             //               color: Colors.white70,
//             //             )),
//             //         const Spacer(),
//             //         Text(
//             //           _effectsList[_effectIndex].name,
//             //           style: const TextStyle(fontSize: 20, color: Colors.white),
//             //         ),
//             //         const Spacer(),
//             //         IconButton(
//             //             iconSize: 60,
//             //             onPressed: () {
//             //               setState(() {
//             //                 String path = _getNextEffect();
//             //                 _controller.switchFilter(path);
//             //               });
//             //             },
//             //             icon: const Icon(
//             //               Icons.arrow_forward_ios,
//             //               color: Colors.white70,
//             //             )),
//             //       ],
//             //     ),
//             //   ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                     onPressed: () async {
//                       // _controller.changeParameter(
//                       //     gameObject: gameObject,
//                       //     component: component,
//                       //     parameter: parameter);
//                       MainProvider mainProviderFalse =
//                           Provider.of<MainProvider>(context, listen: false);
//                       // if (_controller.isRecording) {
//                       //   File? file = await _controller.stopVideoRecording();
//                       //   OpenFile.open(file.path);
//                       // } else {
//                       //   await _controller.startVideoRecording();
//                       // }

//                       // setState(() {});
//                       mainProviderFalse.changeBottomTabIndex(0);
//                     },
//                     iconSize: 50,
//                     color: Colors.white70,
//                     icon: SvgPicture.asset(
//                       'assets/svgs/feed.svg',
//                       height: 4.h,
//                     )),
//                 // const SizedBox(width: 20),

//                 IconButton(
//                   iconSize: 60,
//                   onPressed: () {
//                     if (_isEffectApplied) {
//                       _controller.takeScreenshot().then((file) {
//                         OpenFile.open(file.path);
//                       });
//                     } else {
//                       String nextEffect = _effectsList[0].path;

//                       _controller.switchFilter(nextEffect);
//                     }
//                     setState(() {
//                       _isEffectApplied = true;
//                     });
//                   },
//                   icon: SvgPicture.asset('assets/svgs/camera.svg'),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       // _controller.takeScreenshot().then((file) {
//                       //   OpenFile.open(file.path);
//                       // });
//                       MainProvider mainProviderFalse =
//                           Provider.of<MainProvider>(context, listen: false);

//                       mainProviderFalse.changeBottomTabIndex(2);
//                     },
//                     color: Colors.white70,
//                     iconSize: 40,
//                     icon: SvgPicture.asset(
//                       'assets/svgs/gallery.svg',
//                       height: 4.h,
//                       color: Colors.white70,
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Add effects which are rendered via DeepAR sdk
//   void _initEffects() {
//     _effectsList.clear();

//     _effectsList.add(Filter(
//       name: 'Cheecks and Jaw',
//       path: '${_assetEffectsPath}cheeksAndJaw.deepar',
//       min: 0,
//       max: 100,
//       gameObject: 'Mesh',
//       parameter: 'Cheeks',
//     ));
//     _effectsList.add(Filter(
//       name: 'Lips Injection',
//       path: '${_assetEffectsPath}lipsInjection.deepar',
//       min: 0,
//       max: 100,
//       gameObject: 'Mesh',
//       parameter: 'Lips',
//     ));

//     // _effectsList.add(Filter(
//     //   name: 'Cheeks',
//     //   path: '${_assetEffectsPath}cheeks.deepar',
//     //   min: 0,
//     //   max: 50,
//     //   gameObject: 'Mesh',
//     //   parameter: 'Cheeks',
//     // ));
//     _effectsList.add(Filter(
//       name: 'Chin',
//       path: '${_assetEffectsPath}chin.deepar',
//       min: 0,
//       max: 100,
//       gameObject: 'Mesh',
//       parameter: 'Jaw',
//     ));
//     _effectsList.add(Filter(
//       name: 'Cheecks and Jaw',
//       path: '${_assetEffectsPath}cheeksAndJaw.deepar',
//       min: 0,
//       max: 40,
//       gameObject: 'Mesh',
//       parameter: 'Cheeks',
//     ));
//     // _effectsList.add(Filter(
//     //   name: 'Jaw',
//     //   path: '${_assetEffectsPath}jaw.deepar',
//     //   min: 0,
//     //   max: 50,
//     //   gameObject: 'Mesh.001',
//     //   parameter: 'jaw',
//     // ));
//     // _effectsList.add(Filter(
//     //   name: 'Temple',
//     //   path: '${_assetEffectsPath}temple.deepar',
//     //   min: 0,
//     //   max: 50,
//     //   gameObject: 'Mesh.001',
//     //   parameter: 'temple',
//     // ));

//     // _effectsList.add(_assetEffectsPath+'flower_face.deepar');
//     // _effectsList.add(_assetEffectsPath+'Hope.deepar');
//     // _effectsList.add(_assetEffectsPath+'viking_helmet.deepar');
//     print(_effectsList.length);
//   }

//   /// Get all deepar effects from assets
//   ///
//   Future<List<String>> _getEffectsFromAssets(BuildContext context) async {
//     final manifestContent =
//         await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//     final filePaths = manifestMap.keys
//         .where((path) => path.startsWith(_assetEffectsPath))
//         .toList();
//     return filePaths;
//   }

//   /// Get next effect
//   String _getNextEffect() {
//     _effectIndex < _effectsList.length ? _effectIndex++ : _effectIndex = 0;
//     return _effectsList[_effectIndex].path;
//   }

//   /// Get previous effect
//   String _getPrevEffect() {
//     _effectIndex > 0 ? _effectIndex-- : _effectIndex = _effectsList.length;
//     return _effectsList[_effectIndex].path;
//   }

//   /// Get next mask
//   String _getNextMask() {
//     _maskIndex < _maskList.length ? _maskIndex++ : _maskIndex = 0;
//     return _maskList[_maskIndex];
//   }

//   /// Get previous mask
//   String _getPrevMask() {
//     _maskIndex > 0 ? _maskIndex-- : _maskIndex = _maskList.length;
//     return _maskList[_maskIndex];
//   }

//   /// Get next filter
//   String _getNextFilter() {
//     _filterIndex < _filterList.length ? _filterIndex++ : _filterIndex = 0;
//     return _filterList[_filterIndex];
//   }

//   /// Get previous filter
//   String _getPrevFilter() {
//     _filterIndex > 0 ? _filterIndex-- : _filterIndex = _filterList.length;
//     return _filterList[_filterIndex];
//   }
// }

// class CustomDropDown extends StatefulWidget {
//   final Function(int index) handler;
//   const CustomDropDown({
//     Key? key,
//     required this.handler,
//   }) : super(key: key);

//   @override
//   State<CustomDropDown> createState() => _CustomDropDownState();
// }

// class _CustomDropDownState extends State<CustomDropDown> {
//   int index = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 15.w,
//       height: 25.h,
//       padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.h),
//         color: Colors.white70,
//       ),
//       child:
//           Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         _CircularItem(
//           isSelected: index == 1,
//           onTap: () {
//             setState(() {
//               index = 1;
//             });
//             widget.handler(index);
//           },
//           child: SvgPicture.asset(
//             'assets/svgs/lips.svg',
//             height: 2.5.h,
//             color: index == 1 ? Colors.white : kBlue1,
//           ),
//         ),
//         _CircularItem(
//           isSelected: index == 2,
//           onTap: () {
//             setState(() {
//               index = 2;
//             });
//             widget.handler(index);
//           },
//           child: SmallText(
//             text: 'Round',
//             color: index == 2 ? Colors.white : kBlue1,
//             size: 7,
//           ),
//         ),
//         _CircularItem(
//           isSelected: index == 3,
//           onTap: () {
//             setState(() {
//               index = 3;
//             });
//             widget.handler(index);
//           },
//           child: SmallText(
//             text: 'Round',
//             color: index == 3 ? Colors.white : kBlue1,
//             size: 7,
//           ),
//         ),
//       ]),
//     );
//   }
// }

// class _CircularItem extends StatelessWidget {
//   final Function() onTap;

//   const _CircularItem({
//     Key? key,
//     required this.isSelected,
//     required this.child,
//     required this.onTap,
//   }) : super(key: key);

//   final bool isSelected;

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: CircleAvatar(
//           backgroundColor: isSelected ? Colors.blue : Colors.white,
//           radius: 3.5.h,
//           child: child),
//     );
//   }
// }
