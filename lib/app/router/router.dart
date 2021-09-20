import 'package:arm_test/ui/views/create_post/create_post_view.dart';
import 'package:arm_test/ui/views/edit_post/edit_post_view.dart';
import 'package:arm_test/ui/views/login_view/login_view_view.dart';
import 'package:arm_test/ui/views/sign_up/sign_up_view.dart';
import 'package:arm_test/ui/views/view_posts/view_posts_view.dart';
import 'package:auto_route/auto_route.dart';

import 'package:arm_test/ui/views/home/home_view.dart';
import 'package:arm_test/ui/views/startup/startup_view.dart';

export './router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "View,Route",
  routes: <AutoRoute>[
    AdaptiveRoute(page: StartupView, initial: true),
    AdaptiveRoute(page: HomeView),
    AdaptiveRoute(page: SignUpView),
    AdaptiveRoute(page: LoginView),
    AdaptiveRoute(page: CreatePostView),
    AdaptiveRoute(page: ViewPosts),
    AdaptiveRoute(page: EditPostView)
  ],
)
class $ArmTestRouter {}