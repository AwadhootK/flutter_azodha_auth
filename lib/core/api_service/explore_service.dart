import 'dart:convert';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:azo_auth/core/api_layer/clients/dio_client.dart';
import 'package:azo_auth/core/api_layer/clients/user_service_client.dart';
import 'package:azo_auth/core/api_layer/constants.dart';
import 'package:azo_auth/core/api_service/auth0_api_service.dart';
import 'package:azo_auth/core/api_service/save_blogs_service.dart';
import 'package:azo_auth/core/api_service/user_service.dart';
import 'package:azo_auth/core/config.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:azo_auth/models/explore_type.dart';
import 'package:azo_auth/models/get_blogs_model.dart';
import 'package:azo_auth/models/save_post_response.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class ExploreService {
  late Config authConfig;
  List<ExploreType> blogList = [];
  static List<ExploreType> featuredBlogList = [];
  List<String> allTags = [];
  List<String> filtertags = [];
  static List<String> bookmarkedblogs = [];
  List<String> savedBlogs = [];
  static List<SavePostResponse> saveresplist = [];
  List<ExploreType>? masterlist;
  bool isSearching = false;
  String searchTerm = '';

  ExploreService({required this.authConfig})
      : dio = AuthDependencyInjector.getIt.get<DioClient>().dio,
        auth0authenticationService = Auth0AuthenticationService(authConfig: authConfig),
        userservice =
            AuthDependencyInjector.getIt.get<UserServiceClient>().userservice {
    blogList = [];
    featuredBlogList = [];
    allTags = [];
    filtertags = [];
  }

  Dio dio;
  Auth0AuthenticationService auth0authenticationService;
  UserService userservice;

  final log = Logger('Explore Service');
  Stream<List<String>> getBookmarkedBlogs() async* {
    savedBlogs = await SaveBlogsService.getSavedBlogs();
    savedBlogs = savedBlogs.toSet().toList();
    yield savedBlogs;
  }

  // changeSearchingStatus() {
  //   isSearching = !isSearching;
  //   notifyListeners();
  // }

  // changeSearchTerm(String term) {
  //   searchTerm = term;
  //   notifyListeners();
  // }

  final logger = Logger('Content0Service');
//   loadContentContent0(List<GetBlogsModel> content) {
//     blogList = [];
//     for (GetBlogsModel element in content) {
//       List<String> itemtags = [];
//       List<String> meals = [];
//       //  bool featured = false;
//       // for (Status i in element.properties.tags) {
//       //   itemtags.add(i.name.replaceFirst('#', ''));
//       // }
//       // if (element.properties?.Tags=='featured') {

//       // }
//       allTags.addAll(itemtags);
//       //itemtags.add('featured');
//       allTags = allTags.toSet().toList();

//       element.properties?.categories?.forEach((element) {
//         itemtags.add(element.name ?? '');
//       });
//       // for(var j in element.properties.mealType){
//       //   meals.add(j.name);
//       // }
//       //if (element.properties.img.isNotEmpty) {
// // ! - here

//       if (element.properties?.date?.start
//               ?.toUtc()
//               .isAfter(DateTime.now().toUtc()) ??
//           false) {
//         log.info(element.properties?.date?.start?.toUtc().toString() ?? '');
//         log.info(DateTime.now().toUtc().toString());

//         continue;
//       }

//       ExploreType blogitem = ExploreType(
//           title: element.title ?? '',
//           text: element.id,
//           headerImage: element.properties!.image!.isNotEmpty
//               ? element.properties?.image?.first
//               : null,
//           thumbImage: element.properties!.image!.isNotEmpty
//               ? element.properties?.image?.first
//               : null,
//           tags: itemtags,
//           author: element.properties?.author.toString() ?? "",
//           authorImage: element.properties?.authorProfile?.isNotEmpty ?? false
//               ? element.properties?.authorProfile?.first
//               : "",
//           meals: meals);
//       blogList.add(blogitem);
//       //! - Here

//       //element.properties.mealType.forEach((element) { return element.name;}));

//       //}
//       //element.properties.author);
//     }
//     notifyListeners();
//     log.info('Reached : ${blogList.length}');
//     return blogList;
//   }

  //setfilter tag
  List<String> get tags => allTags;

  Stream<List<ExploreType>> pageContent(List<ExploreType> blogList) async* {
    if (filtertags.isNotEmpty) {
      List<ExploreType> filterlist = [];
      for (ExploreType i in blogList) {
        // bool found = false;
        if (i.tags.toSet().containsAll(filtertags.toSet())) {
          filterlist.add(i);
        }
      }
      yield filterlist;
    } else {
      yield blogList;
    }
  }

  //! handle notifyListeners() here
  Future<List<SavePostResponse>> getusercontent() async {
    Response response;
    Credentials cred = await auth0authenticationService.getCred();
    dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
    String patientId = userservice.fetchCurrentUser().patientid ?? '';
    // String? responsephrase = 'Something Went Wrong';
    String url = '${authConfig.appConfigUrl}api/user-content/users/$patientId';
    log.info(url);
    try {
      saveresplist.forEach((element) {
        savedBlogs.add(element.contentId ?? "");
      });

      log.info(saveresplist.length.toString());
      //! notifyListeners();
      response = await dio.get(url);
      if (response.statusCode == 200) {
        List<dynamic> res = response.data as List<dynamic>;
        saveresplist = [];
        for (var element in res) {
          saveresplist.add(SavePostResponse.fromJson(element));
        }

        return saveresplist;
      } else {}
      return json.decode(response.data);
    } catch (e) {
      log.info(e.toString());
      rethrow;
    }
  }

  // Future<dynamic> deleteusercontent(String contentid) async {
  //   Response response;
  //   Credentials cred = await auth0authenticationService.getCred();
  //   dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
  //   String patientId = userservice.fetchCurrentUser().patientid ?? '';
  //   // String? responsephrase = 'Something Went Wrong';
  //   String url =
  //       '${Config.appConfigUrl}api/user-content/users/$patientId/contents/$contentid';
  //   log.info(url);
  //   savedBlogs.remove(contentid);
  //   notifyListeners();
  //   try {
  //     response = await dio.delete(url);
  //     if (response.statusCode == 200) {
  //     } else {}
  //   } catch (e) {
  //     log.info(e.toString());
  //     rethrow;
  //   }
  // }

  Future<dynamic> postusercontent(String contentid) async {
    Response response;
    Credentials cred = await auth0authenticationService.getCred();
    dio.options.headers['Authorization'] = 'Bearer ${cred.idToken}';
    dio.options.headers['content-Type'] = 'application/json';
    String patientId = userservice.fetchCurrentUser().patientid ?? '';
    // String? responsephrase = 'Something Went Wrong';
    String url = '${authConfig.appConfigUrl}api/user-content';
    log.info(url);
    try {
      response = await dio
          .post(url, data: {"userId": patientId, "contentId": contentid});
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      log.info(e.toString());
      rethrow;
    }
  }

  // void addfiltertag(String value) {
  //   filtertags.add(value);
  //   filtertags = filtertags.toSet().toList();
  //   notifyListeners();
  // }

  // void removefiltertag(String value) {
  //   filtertags.remove(value);
  //   notifyListeners();
  // }
}
