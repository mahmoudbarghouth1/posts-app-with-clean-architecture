import 'package:clean_architecture_posts_app/core/network/network_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/reposotiries/posts_repository_impl.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/add_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/delet_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/get_all_posts.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/update_post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delet_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  //http
  sl.registerLazySingleton(() => http.Client);
  //connectionchaker
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );
  //network
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
  // sharedpreferenced
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data resouces
  sl.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<PostsLocalDataSource>(
    () => PostsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //repository
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      postsRemoteDataSource: sl(),
      postsLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //use_case
  sl.registerLazySingleton(() => GetAllPostsUseCase(postsRepository: sl()));
  sl.registerFactory(() => AddPostUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => DeletPostUseCae(postsRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(postsRepository: sl()));
  //bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
    () => AddDeletUpdatePostBloc(
      addPost: sl(),
      updatepost: sl(),
      deletPost: sl(),
    ),
  );
}

//acasc

// import 'package:clean_architecture_posts_app/core/network/network_info.dart';
// import 'package:clean_architecture_posts_app/features/posts/data/datasources/posts_local_data_source.dart';
// import 'package:clean_architecture_posts_app/features/posts/data/datasources/posts_remote_data_source.dart';
// import 'package:clean_architecture_posts_app/features/posts/data/reposotiries/posts_repository_impl.dart';
// import 'package:clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';
// import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/add_post.dart';
// import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/delet_post.dart';
// import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/get_all_posts.dart';
// import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/update_post.dart';
// import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delet_update_post_bloc.dart';
// import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// final sl = GetIt.instance;
// Future<void> init() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
//   // print("✅ Registered SharedPreferences");
//   sl.registerLazySingleton<InternetConnectionChecker>(
//     () => InternetConnectionChecker.createInstance(),
//   );
//   sl.registerLazySingleton(() => http.Client());

//   sl.registerLazySingleton<NetworkInfo>(
//     (() => NetworkInfoImpl(conectionChecer: sl())),
//   );

//   // print("✅ Registered Repository");
//   sl.registerLazySingleton<PostsRemoteDataSource>(
//     () => PostsRemoteDataSourceImpl(),
//   );
//   // print("✅ Registered RemoteDataSource");
//   // Data sources
//   sl.registerLazySingleton<PostsLocalDataSource>(
//     () => PostsLocalDataSourceImpl(sharedPreferences: sl()),
//   );
//   //repository

//   sl.registerLazySingleton<PostsRepository>(
//     () => PostsRepositoryImpl(
//       postsRemoteDataSource: sl(),
//       postsLocalDataSource: sl(),
//       networkInfo: sl(),
//     ),
//   );
//   // use_case
//   sl.registerLazySingleton(() => GetAllPostsUseCase(postsRepository: sl()));
//   sl.registerLazySingleton(() => AddPostUseCase(postsRepository: sl()));
//   sl.registerLazySingleton(() => UpdatePostUseCase(postsRepository: sl()));
//   sl.registerLazySingleton(() => DeletPostUseCae(postsRepository: sl()));

//   ///features
//   ///posts
//   // posts bloc
//   sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
//   //deleatoraddorupdate bloc
//   sl.registerFactory(
//     () => AddDeletUpdatePostBloc(
//       addPost: sl(),
//       updatepost: sl(),
//       deletPost: sl(),
//     ),
//   );
