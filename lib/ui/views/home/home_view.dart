import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/models/news.dart';
import 'package:arm_test/app/router/router.dart';
import 'package:arm_test/app/services/router_service.dart';
import 'package:arm_test/app/utils/res.dart';
import 'package:arm_test/app/utils/size.dart';
import 'package:arm_test/ui/views/login_view/login_view_view.dart';
import 'package:arm_test/ui/views/view_posts/view_posts_view.dart';
import 'package:arm_test/ui/widgets/dumb/skeleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  final RouterService _routerService = locator<RouterService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return DefaultTabController(
          length: 2,
          child: Skeleton(
            automaticallyImplyLeading: false,
            bodyPadding: EdgeInsets.zero,
            isBusy: model.isBusy,
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                model.navigateTo(CreatePostRoute());
              },
              label: Text('Create Post'),
              icon: Icon(Icons.add),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    model.navigateTo(SignUpRoute());
                  },
                  icon: Icon(Icons.exit_to_app),
                )
              ],
              title: Text(
                'Hello ${FirebaseAuth.instance.currentUser!.displayName ?? 'User'}',
                style: GoogleFonts.dmSans(),
              ),
              bottom: TabBar(
                indicatorColor: Colors.amberAccent,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.article),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                UserPosts(),
                model.news == null
                    ? Center(
                        child: Text(
                          'No recent news!',
                          style: GoogleFonts.dmSans(),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                              children: model.news!.articles!
                                  .map((e) => NewsCard(
                                        article: e,
                                      ))
                                  .toList()),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final Article? article;
  const NewsCard({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () async {
          print(article!.url!);
          if (await canLaunch(article!.url!) == true || false) {
            launch(article!.url!, forceWebView: true, enableJavaScript: true);
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            // height: McGyver.rsDoubleH(context, 40),
            child: Column(
              children: [
                Image.network(
                  article!.urlToImage!,
                ),
                verticalSpaceXSmall(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article!.title!,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                verticalSpaceXSmall(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article!.content!,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserPosts extends StatelessWidget {
  const UserPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: McGyver.rsDoubleH(context, 100),
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Posts')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: Text('You have 0 posts.'),
                )
              : ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPosts(data: data),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            // height: McGyver.rsDoubleH(context, 40),
                            child: Column(
                              children: [
                                Image.network(
                                  data['image'],
                                ),
                                verticalSpaceXSmall(context),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['title'],
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                verticalSpaceXSmall(context),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['description'],
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
    );
  }
}
