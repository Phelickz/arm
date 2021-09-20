// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:arm_test/ui/views/create_post/create_post_view.dart' as _i7;
import 'package:arm_test/ui/views/edit_post/edit_post_view.dart' as _i9;
import 'package:arm_test/ui/views/home/home_view.dart' as _i4;
import 'package:arm_test/ui/views/login_view/login_view_view.dart' as _i6;
import 'package:arm_test/ui/views/sign_up/sign_up_view.dart' as _i5;
import 'package:arm_test/ui/views/startup/startup_view.dart' as _i3;
import 'package:arm_test/ui/views/view_posts/view_posts_view.dart' as _i8;
import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

class ArmTestRouter extends _i1.RootStackRouter {
  ArmTestRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    StartupRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.StartupView();
        }),
    HomeRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HomeView();
        }),
    SignUpRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.SignUpView();
        }),
    LoginRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.LoginView();
        }),
    CreatePostRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.CreatePostView();
        }),
    RoutePosts.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<RoutePostsArgs>();
          return _i8.ViewPosts(key: args.key, data: args.data);
        }),
    EditPostRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<EditPostRouteArgs>();
          return _i9.EditPostView(key: args.key, data: args.data);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(StartupRoute.name, path: '/'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-view'),
        _i1.RouteConfig(SignUpRoute.name, path: '/sign-up-view'),
        _i1.RouteConfig(LoginRoute.name, path: '/login-view'),
        _i1.RouteConfig(CreatePostRoute.name, path: '/create-post-view'),
        _i1.RouteConfig(RoutePosts.name, path: '/view-posts'),
        _i1.RouteConfig(EditPostRoute.name, path: '/edit-post-view')
      ];
}

class StartupRoute extends _i1.PageRouteInfo {
  const StartupRoute() : super(name, path: '/');

  static const String name = 'StartupRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home-view');

  static const String name = 'HomeRoute';
}

class SignUpRoute extends _i1.PageRouteInfo {
  const SignUpRoute() : super(name, path: '/sign-up-view');

  static const String name = 'SignUpRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login-view');

  static const String name = 'LoginRoute';
}

class CreatePostRoute extends _i1.PageRouteInfo {
  const CreatePostRoute() : super(name, path: '/create-post-view');

  static const String name = 'CreatePostRoute';
}

class RoutePosts extends _i1.PageRouteInfo<RoutePostsArgs> {
  RoutePosts({_i2.Key? key, required Map<String, dynamic>? data})
      : super(name,
            path: '/view-posts', args: RoutePostsArgs(key: key, data: data));

  static const String name = 'RoutePosts';
}

class RoutePostsArgs {
  const RoutePostsArgs({this.key, required this.data});

  final _i2.Key? key;

  final Map<String, dynamic>? data;
}

class EditPostRoute extends _i1.PageRouteInfo<EditPostRouteArgs> {
  EditPostRoute({_i2.Key? key, required Map<String, dynamic> data})
      : super(name,
            path: '/edit-post-view',
            args: EditPostRouteArgs(key: key, data: data));

  static const String name = 'EditPostRoute';
}

class EditPostRouteArgs {
  const EditPostRouteArgs({this.key, required this.data});

  final _i2.Key? key;

  final Map<String, dynamic> data;
}
