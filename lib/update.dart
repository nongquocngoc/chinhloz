// import 'dart:developer';
// import 'package:cuoiki_flutter/api.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:cuoiki_flutter/model.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'dart:io';
// import 'package:uuid/uuid.dart';
// import 'package:image/image.dart' as ImD;
// import 'package:cuoiki_flutter/uploadimage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// class update extends StatefulWidget {
//   final String halo;
//   const update({Key key, this.halo}) : super(key: key);
//
//   @override
//   _update createState() => _update();
// }
// class _update extends State<update> {
//   @override
//   Widget build(BuildContext context) {
//     // API.getPosts().then((value) {
//     //   _product = value;
//     // });
//     // print(_product.length);
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: appbar(),
//       body: getBody(),
//     );
//   }
//   Widget appbar() {
//     return PreferredSize(
//       preferredSize: Size.fromHeight(55),
//       child: Container(
//         child: SafeArea(
//           // padding: EdgeInsets.all(8),
//           child: Container(
//             alignment: Alignment.center,
//             height: 60,
//             width: 20,
//             color: Colors.blue,
//             child: new Text(
//               'NongQuocNgoc_17DH111076 - ChuNhat_ca1',
//               style: new TextStyle(fontFamily: 'Billabong', fontSize: 25.0),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget getBody(){
//     return Text(halo);
//   }
// }