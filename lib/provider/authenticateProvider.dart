import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../config/string.dart';
import '../config/api.dart';
import '../model/httpException.dart';

class Category {
  final String? name;
  final String? id;
  final bool? hasChild;
  Category({this.name, this.id, this.hasChild});
}

class Provinces {
  final int? id;
  final int? code;
  final String? name_in_thai;
  final String? name_in_english;
  Provinces({
    this.id,
    this.code,
    this.name_in_thai,
    this.name_in_english,
  });
}

class District {
  final int? id;
  final int? code;
  final String? name_in_thai;
  final String? name_in_english;
  final int? province_id;
  District(
      {this.id,
      this.code,
      this.name_in_thai,
      this.name_in_english,
      this.province_id});
}

class SubDistrict {
  final int? id;
  final int? code;
  final String? name_in_thai;
  final String? name_in_english;
  final int? district_id;
  final String? latitude;
  final String? longitude;
  final int? zip_code;

  SubDistrict(
      {this.id,
      this.code,
      this.name_in_thai,
      this.name_in_english,
      this.district_id,
      this.latitude,
      this.longitude,
      this.zip_code});
}

class AddressRequest {
  final bool? isDefault;
  final String? name;
  final int? lng;
  final String? province;
  final String? district;
  final String? subdistrict;
  final String? postalCode;
  final String? tel;
  final String? id;
  final String? fullname;
  final String? detail;
  final int? lat;
  AddressRequest(
      {this.name,
      this.isDefault,
      this.lng,
      this.province,
      this.district,
      this.subdistrict,
      this.postalCode,
      this.tel,
      this.id,
      this.fullname,
      this.detail,
      this.lat});
}

class Request {
  final String? name;
  final String? description;
  final String? id;
  late final String? status;
  final String? thumbnail;
  final int? unreadMatchCount;
  final String? category;

  Request(
      {this.name,
      this.description,
      this.id,
      this.status,
      this.thumbnail,
      this.unreadMatchCount,
      this.category
      // this.address
      });
}

class User {
  String email;
  String? profilePic;
  User({required this.email, this.profilePic});
}

showAlertDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
    },
  );
}

class AuthenticateProvider with ChangeNotifier {
  String _token = "";
  User _user = User(
    email: '',
  );

  AuthenticateProvider();
  bool get isAuth {
    return _token.isNotEmpty;
  }

  String get token {
    return _token;
  }

  User get user {
    return _user;
  }

  User modifyUserData(response) {
    return User(
      email: response.data['email'],
      profilePic: response.data['profilePic'],
    );
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await Dio().post(apiEndpoint + '/api/auth/signin',
        data: {"email": email, "password": password});
    final token = response.data["accessToken"];
    print(token);
    _token = token;

    final res = await Dio().get(apiEndpoint + '/api/auth/me',
        options: Options(headers: {"Authorization": 'Bearer ' + _token}));
    _user = modifyUserData(res);
    prefs.setString('userToken', _token);
    await tryAutoLogin();
  }

  Future<void> profilePicture(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      await Dio().patch(
        apiEndpoint + '/api/user/profile-pic',
        options: Options(headers: {"Authorization": 'Bearer ' + _token}),
        data: formData,
      );
      print('add success');
    } on DioError catch (e) {
      print(e.response);
    }
  }

  List<Category> categoryList = [];
  List<Category> modifyCategory(data) {
    List<Category> list = [];
    data.forEach((el) {
      list.add(Category(
        name: el['name'],
        id: el['id'],
        hasChild: el['hasChild'],
      ));
    });

    return list;
  }

  Future<List<Category>> fetchCategory(String parent) async {
    try {
      final Response response;
      if (parent.isEmpty) {
        response = await Dio().get(
          apiEndpoint + '/api/category',
        );
      } else {
        response = await Dio().get(apiEndpoint + '/api/category',
            queryParameters: {"parent": parent});
      }
      // print(response);
      categoryList = modifyCategory(response.data.toList());
    } catch (error) {}
    return categoryList;
  }

  Future<void> requestItem(
    List<File> files,
    String name,
    String description,
    String category,
    List<String> targetCategories,
    String addressId,
  ) async {
    try {
      var formData = FormData.fromMap({
        "name": name,
        "description": description,
        "category": category,
        "targetCategories[]": targetCategories,
        "addressId": addressId,
      });
      int temp = 0;

      for (var file in files) {
        formData.files.addAll([
          MapEntry(
            "files",
            await MultipartFile.fromFile(file.path),
          ),
        ]);
      }

      await Dio().post(apiEndpoint + '/api/request',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}),
          data: formData);
      print('request success');
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
  }

  List<Request> listRequest = [];
  List<Set<Category>> listRequestCategory = [];

  List<Request> modifyRequest(List<dynamic> data) {
    List<Request> list = [];
    for (var el in data) {
      list.add(Request(
        name: el['name'],
        description: el['description'],
        id: el['id'],
        status: el['status'],
        thumbnail: el['thumbnail'],
        unreadMatchCount: el['unreadMatchCount'],
        category: el['category'],
      ));
    }

    return list;
  }

  Future<List<Request>> fetchRequest(String status) async {
    try {
      final res = await Dio().get(apiEndpoint + '/api/request',
          queryParameters: {"status": status},
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      listRequest = modifyRequest(res.data.toList());
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
    return listRequest;
  }

  Request listRequestIdDetail = Request();

  Request modifyRequestId(response) {
    return Request(
      name: response.data['name'],
      thumbnail: response.data['thumbnail'],
      description: response.data['description'],
    );
  }

  Future<Request> fetchRequestID(String id) async {
    listRequestIdDetail = Request();
    try {
      final res = await Dio().get(apiEndpoint + '/api/request/$id',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      // print(res);
      listRequestIdDetail = modifyRequestId(res);
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
    return listRequestIdDetail;
  }

  dynamic listInprogress;

  Future<dynamic> fetchRequestIDInProgress(String id) async {
    try {
      final res = await Dio().get(apiEndpoint + '/api/request/$id',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      listInprogress = res.data;
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
    return listInprogress;
  }

  List<Category> requestCategory = [];
  List<Category> requestCategoryTarget = [];

  List<Category> modifyRequestIdCategory(data, String type) {
    List<Category> list = [];
    for (var el in data[type]) {
      list.add(Category(
        name: el['name'],
      ));
    }

    return list;
  }

  List<Category> modifyRequestIdCategoryTarget(data, String type) {
    List<dynamic> list = [];
    data['targetCategories'].forEach(
      (el) => {list.add(el)},
    );
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list[i].length; j++) {
        requestCategoryTarget.add(Category(name: list[i][j]['name']));
      }
    }
    return requestCategoryTarget;
  }

  Future<List<Category>> fetchRequestIDCategory(String id, String type) async {
    requestCategory = [];
    requestCategoryTarget = [];
    try {
      if (type == 'category') {
        final res = await Dio().get(apiEndpoint + '/api/request/$id',
            options: Options(headers: {"Authorization": 'Bearer ' + _token}));
        requestCategory = modifyRequestIdCategory(res.data, type);
      } else {
        final res = await Dio().get(apiEndpoint + '/api/request/$id',
            options: Options(headers: {"Authorization": 'Bearer ' + _token}));
        requestCategoryTarget =
            modifyRequestIdCategoryTarget(res.data, 'targetCategories');
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return type == 'category' ? requestCategory : requestCategoryTarget;
  }

  List<String> requestImage = [];
  List<String> modifyRequestIdImage(data) {
    List<String> list = [];
    for (var el in data) {
      list.add(el);
    }

    return list;
  }

  Future<List<String>> fetchRequestIDImage(String id) async {
    listRequestIdDetail = Request();
    try {
      final res = await Dio().get(apiEndpoint + '/api/request/images/$id',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      requestImage = modifyRequestIdImage(res.data);
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
    return requestImage;
  }

  dynamic defaultAddress = '';
  Future<dynamic> fetchDefaultAddress() async {
    try {
      final res = await Dio().get(apiEndpoint + '/api/user/address/default',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      // print(res.data);
      defaultAddress = res.data;
    } on DioError {}
    return defaultAddress;
  }

  List<dynamic> list = [];

  Future<List<dynamic>> fetchRequestIDMatched(String id) async {
    list = [];
    listRequestIdDetail = Request();
    try {
      final res = await Dio().get(apiEndpoint + '/api/request/match/$id',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      list = res.data;
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
    return list;
  }

  Future<dynamic> fetchRequestIDMatchedDetail(
      String sourceReq, String targetReq) async {
    dynamic list;
    listRequestIdDetail = Request();
    try {
      final res = await Dio().get(
          apiEndpoint + '/api/request/match/detail/$sourceReq/$targetReq',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      list = res.data;
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
    return list;
  }

  Future<void> patchConfirm(
    String sourceRequestId,
    String targetRequestId,
    bool isConfirm,
  ) async {
    try {
      await Dio().patch(
          apiEndpoint +
              '/api/request/status/$sourceRequestId/$targetRequestId?isConfirmed=$isConfirm',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> addEvidence(String requestId, File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    try {
      await Dio().post(
        apiEndpoint + '/api/request/$requestId/evidence',
        options: Options(headers: {"Authorization": 'Bearer ' + _token}),
        data: formData,
      );
      print('add evidence successfull');
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> requestReceive(String sourceRequestId, String targetRequestId,
      double ratingScore) async {
    try {
      print(ratingScore);
      await Dio().post(
        apiEndpoint + '/api/request/receive',
        data: {
          "sourceRequestId": sourceRequestId.toString(),
          "targetRequestId": targetRequestId.toString(),
          "ratingScore": ratingScore,
        },
        options: Options(headers: {"Authorization": 'Bearer ' + _token}),
      );
      print('add evidence successfull');
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> addAddress(
    String fullname,
    String tel,
    String province,
    String district,
    String subdistrict,
    String postalCode,
    String detail,
    int lat,
    int lng,
  ) async {
    try {
      Map data = {
        "fullname": fullname,
        "tel": tel,
        "province": province,
        "district": district,
        "subdistrict": subdistrict,
        "postalCode": postalCode,
        "detail": detail,
        "lat": 1,
        "lng": 2,
      };
      var body = json.encode(data);

      await Dio().post(apiEndpoint + '/api/user/address',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}),
          data: body);
      print('add address success');
    } on DioError catch (e) {
      print(e.response);
    }
  }

  List<AddressRequest> addressRequest = [];
  List<AddressRequest> modifyAddress(List<dynamic> data) {
    List<AddressRequest> list = [];
    for (var el in data) {
      list.add(AddressRequest(
          isDefault: el['isDefault'],
          id: el['id'],
          fullname: el['fullname'],
          tel: el['tel'],
          detail: el['detail'],
          province: el['province'],
          subdistrict: el['subdistrict'],
          postalCode: el['postalCode'],
          district: el['district']));
    }
    return list;
  }

  Future<List<AddressRequest>> fetchAddress() async {
    try {
      final res = await Dio().get(apiEndpoint + '/api/user/address',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));

      addressRequest = modifyAddress(res.data.toList());
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
    return addressRequest;
  }

  late AddressRequest addressById;

  AddressRequest modifyAddressById(dynamic el) {
    return AddressRequest(
      isDefault: el['isDefault'],
      id: el['id'],
      fullname: el['fullname'],
      tel: el['tel'],
      detail: el['detail'],
      province: el['province'],
      subdistrict: el['subdistrict'],
      postalCode: el['postalCode'],
      district: el['district'],
      lat: el['lat'],
      lng: el['lng'],
    );
  }

  Future<AddressRequest> fetchAddressById(String id) async {
    try {
      final res = await Dio().get(apiEndpoint + '/api/user/address/$id',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      addressById = modifyAddressById(res.data);
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
    return addressById;
  }

  Future<void> editAddress(
    String id,
    String fullname,
    String tel,
    String province,
    String district,
    String subdistrict,
    String postalCode,
    String detail,
    int? lat,
    int? lng,
  ) async {
    try {
      Map data = {
        "fullname": fullname,
        "tel": tel,
        "province": province,
        "district": district,
        "subdistrict": subdistrict,
        "postalCode": postalCode,
        "detail": detail,
        "lat": 1,
        "lng": 2,
      };
      var body = json.encode(data);

      await Dio().patch(apiEndpoint + '/api/user/address/$id',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}),
          data: body);
      print('edit address success');
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> changeDefaultAddress(
    String id,
  ) async {
    try {
      await Dio().post(
        apiEndpoint + '/api/user/address/default/$id',
        options: Options(headers: {"Authorization": 'Bearer ' + _token}),
      );
      print('change default address success');
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> verify(
    String otp,
  ) async {
    try {
      await Dio().post(apiEndpoint + '/api/auth/verify', data: {
        "otp": otp,
      });
    } catch (error) {
      print(error);
    }
  }

  Future<User> fetchProfile() async {
    try {
      final res = await Dio().get(apiEndpoint + '/api/auth/me',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      _user = modifyUserData(res);
    } catch (error) {
      print(error);
    }
    return _user;
  }

  Future<void> register(
    String email,
    String password,
  ) async {
    try {
      await Dio().post(apiEndpoint + '/api/auth/signup', data: {
        "email": email,
        "password": password,
      });
    } catch (error) {
      throw HttpException(usedEmailException);
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return;

    String token = prefs.getString('userToken').toString();
    _token = token;
    try {
      final res = await Dio().get(apiEndpoint + '/api/auth/me',
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      _user = modifyUserData(res);
      notifyListeners();
    } catch (error) {
      prefs.clear();
      _token = "";
    }
  }

  Future<void> signOut() async {
    _token = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      await Dio().post(apiEndpoint + '/api/auth/change-password',
          data: {
            "currentPassword": currentPassword,
            "newPassword": newPassword
          },
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      Timer(const Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {}
  }

  Future<void> forgetPassword(String email) async {
    try {
      await Dio().post(apiEndpoint + '/api/auth/forget-password',
          data: {"email": email},
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      Timer(const Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {}
  }

  Future<void> resetPassword(String otp, String newPassword) async {
    try {
      await Dio().post(apiEndpoint + '/api/auth/reset-password',
          data: {"otp": otp, "newPassword": newPassword},
          options: Options(headers: {"Authorization": 'Bearer ' + _token}));
      Timer(const Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {
      print(error);
    }
  }
}
