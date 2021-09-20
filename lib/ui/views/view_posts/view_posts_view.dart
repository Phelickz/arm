import 'package:arm_test/app/router/router.dart';
import 'package:arm_test/app/utils/size.dart';
import 'package:arm_test/ui/widgets/dumb/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_context/one_context.dart';
import 'package:stacked/stacked.dart';

import './view_posts_view_model.dart';

class ViewPosts extends StatelessWidget {
  final Map<String, dynamic>? data;

  const ViewPosts({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewModel>.reactive(
      viewModelBuilder: () => ViewModel(),
      onModelReady: (ViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        ViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          backgroundColor: Colors.white,
          isBusy: model.isBusy,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              model.navigateTo(EditPostRoute(data: data!));
            },
            child: Icon(Icons.edit),
          ),
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: TextButton(
                  onPressed: () async {
                    OneContext().showDialog(builder: (context) {
                      return AlertDialog(
                        title: Text('Confirm Action'),
                        content: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Text('Are you sure you want to delete?'),
                              verticalSpaceXSmall(context),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        model.goBack();
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        model.delete(data!['id']);
                                      },
                                      child: Text('Yes'))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Delete',
                    style: GoogleFonts.dmSans(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          bodyPadding: EdgeInsets.zero,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall(context),
                Image.network(data!['image']),
                verticalSpaceXSmall(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data!['title'],
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
                    data!['description'],
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
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
