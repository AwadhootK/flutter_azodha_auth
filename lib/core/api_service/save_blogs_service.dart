
import 'package:azo_auth/core/api_layer/clients/explore_service_client.dart';
import 'package:azo_auth/core/api_service/explore_service.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:azo_auth/models/save_post_response.dart';
import 'package:hive/hive.dart';

class SaveBlogsService {
  static late Box box;
  static late List<String> blogs;
  ExploreService exploreService;

  SaveBlogsService()
      : exploreService = AuthDependencyInjector.getIt
            .get<ExploreServiceClient>()
            .exploreService;

  static Future<void> init() async {
    box = await Hive.openBox('savedblogs');
    blogs = await box.get(0) ?? [];
  }

  static Future<List<String>> getSavedBlogs() async {
    blogs = await box.get(0) ?? [];
    return blogs;
  }

  static Future<void> saveBlog(String blog) async {
    blogs.add(blog);
    await box.put(0, blogs);
  }

  Future<void> setSavedBlog() async {
    List<String> blogs = [];
    List<SavePostResponse> savedblogs = await exploreService.getusercontent();
    for (SavePostResponse element in savedblogs) {
      if (element.contentId != null) {
        blogs.add(element.contentId!);
      }
    }
    await box.put(0, blogs);
  }

  static Future<void> deleteBlog(String blog) async {
    blogs.removeWhere((item) => item == blog);
    await box.putAt(0, blogs);
  }
}
