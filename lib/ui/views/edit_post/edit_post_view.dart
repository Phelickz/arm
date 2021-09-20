import 'package:arm_test/app/router/router.gr.dart';
import 'package:arm_test/app/utils/res.dart';
import 'package:arm_test/app/utils/size.dart';
import 'package:arm_test/ui/widgets/dumb/button.dart';
import 'package:arm_test/ui/widgets/dumb/skeleton.dart';
import 'package:arm_test/ui/widgets/smart/textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './edit_post_view_model.dart';

class EditPostView extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditPostView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _EditPostViewState createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  final title = TextEditingController();
  final description = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        title.text = widget.data['title'];
        description.text = widget.data['description'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditPostViewModel>.reactive(
      viewModelBuilder: () => EditPostViewModel(),
      onModelReady: (EditPostViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        EditPostViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          isBusy: model.isBusy,
          appBar: AppBar(
            title: Text('Edit Post'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: McGyver.rsDoubleW(context, 3),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceSmall(context),
                    CustomTextField(
                      labelText: 'Title',
                      keyboardType: TextInputType.text,
                      controller: title,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                      },
                    ),
                    verticalSpaceSmall(context),
                    Text(
                      'Description',
                      style: GoogleFonts.dmSans(),
                    ),
                    verticalSpaceXSmall(context),
                    TextFormField(
                      maxLines: 10,
                      controller: description,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    verticalSpaceSmall(context),
                    verticalSpaceSmall(context),
                    model.image != null
                        ? Text('...${model.image!.path}')
                        : SizedBox.shrink(),
                    verticalSpaceXSmall(context),
                    SizedBox(
                      width: McGyver.rsDoubleW(context, 40),
                      child: CustomButtons.generalButton(
                          context: context,
                          onTap: () {
                            model.selectImage();
                          },
                          text: 'New Image'),
                    ),
                    verticalSpaceMedium(context),
                    CustomButtons.generalButton(
                        context: context,
                        onTap: () async {
                          final formKey = form.currentState;
                          if (formKey!.validate()) {
                            if (model.image != null) {
                              String? doc = await model.uploadImage(
                                  description: description.text,
                                  file: model.image!,
                                  title: title.text,
                                  id: widget.data['id']);
                              if (doc != null) {
                                model.navigateTo(HomeRoute());
                              }
                            } else {
                              String? doc = await model.justContent(
                                  title: title.text,
                                  description: description.text,
                                  id: widget.data['id']);

                              if (doc != null) {
                                model.navigateTo(HomeRoute());
                              }
                            }
                          }
                        },
                        text: 'Update')
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
