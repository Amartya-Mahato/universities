import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universities/logic/bloc/form_bloc.dart';
import 'package:universities/logic/event/form_event.dart';
import 'package:universities/logic/state/form_state.dart';

import '../../logic/bloc/auth_bloc.dart';
import '../../logic/bloc/image_upload_bloc.dart';
import '../../logic/event/image_upload_event.dart';
import '../../logic/state/auth_state.dart';
import '../../logic/state/image_upload_state.dart';

String? name;
int? age;

enum Type { isName, isAge }

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _imageUpload(),
            _textField(
                context: context,
                hintText: 'Full Name',
                icon: const Icon(Icons.person),
                type: Type.isName),
            _textField(
                context: context,
                hintText: 'Age',
                icon: const Icon(Icons.person_search_rounded),
                type: Type.isAge),
            _confirmButton(),
          ],
        ),
      )),
    );
  }

  Widget _textField(
      {required BuildContext context,
      required String hintText,
      required Icon icon,
      required Type type}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (authContext, state) {
          return TextField(
              keyboardType: type == Type.isAge ? TextInputType.number : null,
              onChanged: (value) {
                if (type == Type.isName) {
                  name = value;
                } else if (type == Type.isAge) {
                  age = int.parse(value);
                }
              },
              decoration: InputDecoration(
                prefixIcon: icon,
                errorText: authContext.watch<FormBloc>().state.message,
                hintText: hintText,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 5.0,
                    )),
              ));
        },
      ),
    );
  }

  Widget _imageUpload() {
    return BlocConsumer<ImageUploadBloc, ImageUploadState>(
      listener: (imageUploadContext, state) {},
      builder: (imageUploadContext, state) {
        return Padding(
            padding: const EdgeInsets.all(60.0),
            child: InkWell(
              onTap: () {
                imageUploadContext.read<ImageUploadBloc>().add(UploadImage());
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image:
                      imageUploadContext.watch<ImageUploadBloc>().state.image !=
                              null
                          ? DecorationImage(
                            fit: BoxFit.cover,
                              image: Image.memory(imageUploadContext
                                      .watch<ImageUploadBloc>()
                                      .state
                                      .image!)
                                  .image)
                          : null,
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.black, width: 3)
                ),
                child:
                    imageUploadContext.watch<ImageUploadBloc>().state.image ==
                            null
                        ? const Center(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 50,
                            ),
                          )
                        : null,
              ),
            ));
      },
    );
  }

  Widget _confirmButton() {
    return BlocConsumer<FormBloc, FormsState>(
      listener: (formContext, state) {
        if (state == const FormSubmittedState()) {
          ScaffoldMessenger.of(formContext).showSnackBar(
              const SnackBar(content: Text('Successful')));
          Future.delayed(const Duration(seconds: 1));
          SharedPreferences.getInstance().then((instance) {
            instance.setBool('login', true);
          });

          Navigator.pushNamedAndRemoveUntil(formContext, '/homePage', ((route) => false));
        }
      },
      builder: (formContext, state) {
        return state == const FormSubmittingState()
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  Uint8List image =
                      formContext.read<ImageUploadBloc>().state.image!;
                  String email = formContext.read<AuthBloc>().state.email!;
                  formContext.read<FormBloc>().add(FormSubmissionEvent(
                      name: name!, age: age!, image: image, email: email));
                },
                child: const Text('Confirm'));
      },
    );
  }
}
