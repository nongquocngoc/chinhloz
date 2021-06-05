import 'package:cuoiki_flutter/model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class API {
  static const String url =
      'http://api.phanmemquocbao.com/api/Doituong/getobjectsall?tokenget=lethibaotran';

  static Future<List<Product>> getPosts() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/getobjectsall?tokenget=lethibaotran'));
      if (response.statusCode == 200) {
        final List<Product> posts = productFromJson(response.body);
        return posts;
      } else {
        return List<Product>();
      }
    } catch (e) {
      return List<Product>();
    }
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
    try {
      final response = await http.post(Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/InsertObjects?p0=$msvs&id=$id&p1=$ten&p2=$lop&p3=$nganh&p4=$email&p5=$chuongtrinh&p6=$sdt&tokenin=lethibaotran'));
      if (response.statusCode == 200) {
        return ;
      } else {
        return List<Product>();
      }
    } catch (e) {
      return List<Product>();
    }
  }

  static deleteProduct(
      int id,
      ) async {
    try {
      final response = await http.post(Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/deleteObject?id=$id&tokende=lethibaotran'));
      if (response.statusCode == 200) {
        return ;
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
    try {
      final response = await http.post(Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/updateObjects?p0=$msvs&id=$id&p1=$ten&p2=$lop&p3=$nganh&p4=$email&p5=$chuongtrinh&p6=$sdt&tokenin=lethibaotran'));
      if (response.statusCode == 200) {
        return ;
      } else {
        return List<Product>();
      }
    } catch (e) {
      return List<Product>();
    }
  }
}
