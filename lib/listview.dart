import 'dart:developer';
import 'package:cuoiki_flutter/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:cuoiki_flutter/model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as ImD;
import 'package:cuoiki_flutter/uploadimage.dart';
import 'package:cuoiki_flutter/update.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class listview extends StatefulWidget {
  @override
  _listview createState() => _listview();
}

class _listview extends State<listview> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  bool _isLoaderVisible = false;
  List<Product> _product;

  String s = 'notok';
  File file;
  Data _data;
  bool uploading = false;
  String base64Image;
  String status = '';
  String postId = Uuid().v4();
  static final TextEditingController idcontroller = new TextEditingController();
  static final TextEditingController mssvcontroller =
      new TextEditingController();
  static final TextEditingController tencontroller =
      new TextEditingController();
  static final TextEditingController lopcontroller =
      new TextEditingController();
  static final TextEditingController nganhcontroller =
      new TextEditingController();
  static final TextEditingController emailcontroller =
      new TextEditingController();
  static final TextEditingController truongtrinhcontroller =
      new TextEditingController();
  static final TextEditingController sdtcontroller =
      new TextEditingController();

  // var _textStyleBlack = new TextStyle(fontSize: 12.0, color: Colors.black);
  // var _textStyleGrey = new TextStyle(fontSize: 12.0, color: Colors.grey);
  // var _textStyleBlueGrey =
  // new TextStyle(fontSize: 12.0, color: Colors.blueGrey);

  startUpload() {
    if (s == "ok") {
      String fileName = file.path.split('/').last;
      upload(fileName);
    } else {
      print(_data.data.url);
    }
  }

  startUpdate(int id) {
    if (s == "ok") {
      String fileName = file.path.split('/').last;
      update(fileName, id);
    } else {
      print(_data.data.url);
    }
  }

  clearPostInfo() async {
    Navigator.pop(context);
    setState(() {
      idcontroller.clear();
      tencontroller.clear();
      mssvcontroller.clear();
      lopcontroller.clear();
      nganhcontroller.clear();
      emailcontroller.clear();
      sdtcontroller.clear();
      file = File('');
    });
  }

  compressPhoto() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    ImD.Image mImageFile = ImD.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 60));
    setState(() {
      file = compressedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    API.getPosts().then((value) {
      _product = value;
    });
    print(_product.length);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Nguyen Xuan Chinh _ 17DH111080')),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newupload(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget wuserid() {
    return new Container(
        child: new TextField(
      controller: idcontroller,
      decoration: new InputDecoration(
          // hintText: 'nhap id',
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.black),
          ),
          isDense: true),
      // style: _textStyleBlack),
    ));
  }

  Widget wmssv() {
    return new Container(
        child: new TextField(
      controller: mssvcontroller,
      decoration: new InputDecoration(
          // hintText: 'nhap mssv',
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.black),
          ),
          isDense: true),
      // style: _textStyleBlack),
    ));
  }

  Widget wten() {
    return new Container(
        child: new TextField(
      controller: tencontroller,
      decoration: new InputDecoration(
          // hintText: 'nhap ten',
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.black),
          ),
          isDense: true),
      // style: _textStyleBlack),
    ));
  }

  Widget wlop() {
    return new Container(
        child: new TextField(
      controller: lopcontroller,
      decoration: new InputDecoration(
          // hintText: 'nhap lop',
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.black),
          ),
          isDense: true),
      // style: _textStyleBlack),
    ));
  }

  Widget wnganh() {
    return new Container(
        child: new TextField(
      controller: nganhcontroller,
      decoration: new InputDecoration(
          // hintText: 'nhap nganh',
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.black),
          ),
          isDense: true),
      // style: _textStyleBlack),
    ));
  }

  Widget wemail() {
    return new Container(
        child: new TextField(
      controller: emailcontroller,
      decoration: new InputDecoration(
          // hintText: 'email',
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.black),
          ),
          isDense: true),
      // style: _textStyleBlack),
    ));
  }

  Widget wchuongtrinh() {
    return new Container(
        child: new TextField(
      controller: truongtrinhcontroller,
      decoration: new InputDecoration(
          // hintText: 'nhap chuong trinh',
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.black),
          ),
          isDense: true),
      // style: _textStyleBlack),
    ));
  }

  Widget wsdt() {
    return new Container(
        child: new TextField(
            controller: sdtcontroller,
            decoration: new InputDecoration(
                // hintText: 'nhap so dien thoai',
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black),
                ),
                isDense: true)
            // style: _textStyleBlack),
            ));
  }

  // Widget appbar() {
  //   return PreferredSize(
  //     preferredSize: Size.fromHeight(55),
  //     child: Container(
  //       child: SafeArea(
  //         // padding: EdgeInsets.all(8),
  //         child: Container(
  //           alignment: Alignment.center,
  //           height: 60,
  //           width: 20,
  //           color: Colors.blue,
  //           child: new Text(
  //             'NongQuocNgoc_17DH111076 - ChuNhat_ca1',
  //             style: new TextStyle(fontFamily: 'Billabong', fontSize: 25.0),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  takeImage(mContext, int id, String phone, String mssv, String ten, String lop,
      String email, String hinh, String nganh) {
    int _id = id;
    return showDialog(
      context: mContext,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Quan Ly",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Divider(),
            Column(
              children: [
                SimpleDialogOption(
                    child: Text(
                      "Call",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      launch("tel://$phone");
                    }),
                SimpleDialogOption(
                    child: Text(
                      "UpDate",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      newupdate(context, _id, mssv, ten, lop, nganh, email,
                          phone, hinh);
                    }),
                SimpleDialogOption(
                    child: Text(
                      "Xoa user",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      context.loaderOverlay.show();
                      final response = await http.get(Uri.parse(
                          'http://api.phanmemquocbao.com/api/Doituong/deleteObject?id=$id&tokende=lethibaotran'));
                      print(id);
                    }),
                SimpleDialogOption(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  newupload(mContext) {
    return showDialog(
      context: mContext,
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: bodyUpload(),
          ),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Trở về",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () => clearPostInfo(),
                icon: Icon(
                  Icons.delete,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  newupdate(mContext, int id, String mssv, String ten, String lop, String nganh,
      String email, String sdt, String hinh) {
    return showDialog(
      context: mContext,
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: bodyUpdate(id, mssv, ten, lop, nganh, email, sdt, hinh),
          ),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Trở về",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () => clearPostInfo(),
                icon: Icon(
                  Icons.delete,
                  size: 30.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  Widget bodyUpdate(int id, String mssv, String ten, String lop, String nganh,
      String email, String phone, String hinh) {
    idcontroller.text = id.toString();
    tencontroller.text = ten;
    mssvcontroller.text = mssv;
    lopcontroller.text = lop;
    nganhcontroller.text = nganh;
    emailcontroller.text = email;
    sdtcontroller.text = phone;
    return LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SpinKitCircle(
            color: Colors.red,
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.8,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1, color: Colors.grey),
                          image: DecorationImage(
                              image: s != ('ok')
                                  ? NetworkImage('')
                                  : FileImage(file),
                              fit: BoxFit.cover))),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0, bottom: 5.0),
                        child: RaisedButton(
                          child: Text(
                            "AVATAR",
                            style:
                            TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          color: Colors.blue,
                          onPressed: () => layanh(context),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Text("Nhập ID"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wuserid(),
              ),
              Text("Nhập Mã số"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wmssv(),
              ),
              Text("Nhập Tên"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wten(),
              ),
              Text("Nhập loại"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wlop(),
              ),
              Text("Nhập nơi sản xuất"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wnganh(),
              ),
              Text("Nhập địa chỉ"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wemail(),
              ),
              // new Padding(
              //   padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              //   child: wchuongtrinh(),
              // ),
              Text("Nhập Số điện thoại"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wsdt(),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  "Thêm",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.blue,
                onPressed: () => startUpdate(id),
              ),
            ],
          ),
        ));
  }

  Widget bodyUpload() {
    return LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SpinKitCircle(
            color: Colors.red,
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.8,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1, color: Colors.grey),
                          image: DecorationImage(
                              image: s != ('ok')
                                  ? NetworkImage('')
                                  : FileImage(file),
                              fit: BoxFit.cover))),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0, bottom: 5.0),
                        child: RaisedButton(
                          child: Text(
                            "AVATAR",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          color: Colors.blue,
                          onPressed: () => layanh(context),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Text("Nhập ID"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wuserid(),
              ),
              Text("Nhập Mã số"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wmssv(),
              ),
              Text("Nhập Tên"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wten(),
              ),
              Text("Nhập loại"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wlop(),
              ),
              Text("Nhập nơi sản xuất"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wnganh(),
              ),
              Text("Nhập địa chỉ"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wemail(),
              ),
              // new Padding(
              //   padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              //   child: wchuongtrinh(),
              // ),
              Text("Nhập Số điện thoại"),
              new Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: wsdt(),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  "Thêm",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.blue,
                onPressed: () => startUpload(),
              ),
            ],
          ),
        ));
  }

  layanh(mContext) {
    return showDialog(
      context: mContext,
      builder: (context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Text(
                "Select Image from Gallery",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    File imagefile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      s = 'ok';
      this.file = imagefile;
      print(file);
      print(s);
    });
  }

  upload(String fileName) async {
    final id = int.parse(idcontroller.text);
    final mssv = mssvcontroller.text;
    final ten = tencontroller.text;
    final lop = lopcontroller.text;
    final nganh = nganhcontroller.text;
    final email = emailcontroller.text;
    final sdt = sdtcontroller.text;
    List<int> imageBytes = file.readAsBytesSync();
    base64Image = base64.encode(imageBytes);
    log(fileName);
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          'https://api.imgbb.com/1/upload?key=65a52e41be0d263e2c5e13284c1da0af'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    var res = await request.send();
    final test = res.statusCode;
    final response = await http.Response.fromStream(res);
    log(test.toString());
    _data = dataFromJson(response.body);
    print(_data.data.url);
    addProduct(id, mssv, ten, lop, nganh, email, _data.data.url, sdt);
    clearPostInfo();
  }

  update(String fileName, int id) async {
    // final id = int.parse(idcontroller.text);
    final mssv = mssvcontroller.text;
    final ten = tencontroller.text;
    final lop = lopcontroller.text;
    final nganh = nganhcontroller.text;
    final email = emailcontroller.text;
    final sdt = sdtcontroller.text;
    List<int> imageBytes = file.readAsBytesSync();
    base64Image = base64.encode(imageBytes);
    log(fileName);
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          'https://api.imgbb.com/1/upload?key=65a52e41be0d263e2c5e13284c1da0af'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    var res = await request.send();
    final test = res.statusCode;
    final response = await http.Response.fromStream(res);
    log(test.toString());
    _data = dataFromJson(response.body);
    print(_data.data.url);
    updateProduct(id, mssv, ten, lop, nganh, email, _data.data.url, sdt);
    clearPostInfo();
  }

  static addProduct(
    int id,
    String msvs,
    String ten,
    String lop,
    String nganh,
    String email,
    String chuongtrinh,
    String sdt,
  ) async {
    print("dang them");
    try {
      final response = await http.get(Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/InsertObjects?p0=$msvs&id=$id&p1=$ten&p2=$lop&p3=$nganh&p4=$email&p5=$chuongtrinh&p6=$sdt&tokenin=lethibaotran'));
      if (response.statusCode == 200) {
        print("oke ngon");
      } else {
        return List<Product>();
      }
    } catch (e) {
      return List<Product>();
    }
  }

  static updateProduct(
    int id,
    String msvs,
    String ten,
    String lop,
    String nganh,
    String email,
    String chuongtrinh,
    String sdt,
  ) async {
    print("dang update");
    try {
      final response = await http.get(Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/updateObjects?id=$id&p0=$msvs&p1=$ten&p2=$lop&p3=$nganh&p4=$email&p5=$chuongtrinh&p6=$sdt&tokenup=lethibaotran'));
      if (response.statusCode == 200) {
        print("oke ngon");
      } else {
        return List<Product>();
      }
    } catch (e) {
      return List<Product>();
    }
  }

  Widget getBody() {
    API.getPosts().then((value) {
      _product = value;
    });
    return LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SpinKitCircle(
            color: Colors.red,
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.8,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(25.0),
              child: new Column(
                  children: List.generate(
                      _product == null ? 1 : _product.length, (index) {
                Product product = _product[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      new InkWell(
                        onLongPress: () async {
                          takeImage(
                              context,
                              product.id,
                              product.sdt,
                              product.msvs,
                              product.ten,
                              product.lop,
                              product.email,
                              product.chuongtrinh,
                              product.nganh);
                          await Future.delayed(Duration(seconds: 3));
                          setState(() {
                            _isLoaderVisible = context.loaderOverlay.visible;
                          });
                          if (_isLoaderVisible) {
                            context.loaderOverlay.hide();
                          }
                          setState(() {
                            _isLoaderVisible = context.loaderOverlay.visible;
                          });
                          getBody();
                        }, // Handle your callback
                        child: Row(
                          children: [
                            Container(
                              height: 58,
                              width: 58,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 0, color: Colors.grey),
                                image: DecorationImage(
                                    image: NetworkImage(product.chuongtrinh),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                                height: 25,
                                width: 200,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Text(product.ten),
                                )),
                            FloatingActionButton(
                              onPressed: () async {final response = await http.get(Uri.parse(
                                'http://api.phanmemquocbao.com/api/Doituong/deleteObject?id=${product.id}&tokende=lethibaotran'));},
                              child: const Icon(Icons.delete),
                              backgroundColor: Colors.blue,
                            ),
                            FloatingActionButton(
                              onPressed: () => {
                                newupdate(context, product.id, product.msvs, product.ten, product.lop, product.nganh, product.email,
                              product.sdt, product.chuongtrinh)
                                },
                              child: const Icon(Icons.edit),
                              backgroundColor: Colors.blue,
                            ),
                            FloatingActionButton(
                              onPressed: () async {
                                launch('mailto:smith@example.org?subject=News&body=New%20plugin');
                              },
                              child: const Icon(Icons.email),
                              backgroundColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      // ListTile(
                      //   title: Text(product.ten == null ? 'cc' : product.ten),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      //   onLongPress: () {
                      //     takeImage(context, product.id);
                      //   },
                      // ),
                    ],
                  ),
                );
              })),
            ),
          ],
        ));
  }
}
