import 'dart:io';
import 'package:intl/intl.dart';
import 'package:booking/data/models/auth/form/decoration_input_field.dart';
import 'package:booking/data/models/auth/form/input_field_form.dart';
import 'package:booking/data/models/auth/register/button_sign_up.dart';
import 'package:booking/helper/constant/form_keys/registers_keys.dart';
import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/pick_image_from_camera.dart';
import 'package:booking/helper/constant/pick_image_from_gallery.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/alert_dialog.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/methods/to_capitalize.dart';
import 'package:booking/helper/test/navigation_observe.dart';
import 'package:booking/presentation/cubit/auth/register/register_cubit.dart';
import 'package:booking/presentation/views/My_Booking_view.dart';
import 'package:booking/presentation/views/appartement_details_view.dart';
import 'package:booking/presentation/views/auth/login_view.dart';
import 'package:booking/presentation/views/favorite_apartments_view.dart';
import 'package:booking/presentation/views/rate_your_stay_view.dart';
import 'package:booking/presentation/views/tenant_view.dart';
import 'package:booking/presentation/views/Land_Lord_Add_Apartment.dart';
import 'package:booking/presentation/views/Land_Lord_Dashboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';

typedef VoidCallBackFile = void Function(File?);
typedef FileCallBackvoid = File? Function();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*
      // dark mode and light mode setting
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        )
      themeMode: ThemeMode.light,
      */
      debugShowCheckedModeBanner: false,
      navigatorObservers: [Observ()],
      routes: {
        tenantView: (context) => TenantView(),
        appartementDetailsView: (context) => AppartementDetailsView(),
        rateYourStayView: (context) => RateYourStayView(),
        favoriteApartments: (context) => FavoriteApartments(),
        addApartment: (context) => LandLordAddApartment(),
        landlordDashBoard: (context) => LandLordDashboard(),
        mybooking: (context) => MyBookingView(),
        loginView: (context) => LoginView(),
      },
      home: LoginView(),
      // initialRoute: favoriteApartments,
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late GlobalKey<FormBuilderState> formKey;

  File? imageProfile = File("");
  File? imageIDCard = File("");

  void setImageProfile(File? image) {
    imageProfile = image;
  }

  void setImageIDCard(File? image) {
    imageIDCard = image;
  }

  File? getImageProfile() {
    return imageProfile;
  }

  File? getImageIDCard() {
    return imageIDCard;
  }

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormBuilderState>();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(rem(2)),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FormBuilder(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: ListView(
                    children: [
                      SectionImagePickerProfile(
                        constraints: constraints,
                        fun: setImageProfile,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: rem(1)),
                        child: SectionGroupOfInputField(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: rem(1)),
                        child: SectionPickImagePictureID(fun: setImageIDCard),
                      ),
                      BlocProvider(
                        create: (_) => RegisterCubit(),
                        child: ButtonSignUp(
                          formKey: formKey,
                          imageProfile: getImageProfile(),
                          imageIDCard: getImageIDCard(),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do you have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: rem(1),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: rem(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SectionPickImagePictureID extends StatefulWidget {
  const SectionPickImagePictureID({super.key, required this.fun});

  final VoidCallBackFile fun;

  @override
  State<SectionPickImagePictureID> createState() =>
      _SectionPickImagePictureIDState();
}

class _SectionPickImagePictureIDState extends State<SectionPickImagePictureID> {
  final ImagePicker imagePicker = ImagePicker();
  ValueNotifier<File?> image = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: rem(1)),
          child: image.value == null
              ? null
              : Text(
                  "Image ID : ",
                  style: TextStyle(
                    fontSize: rem(1.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        GestureDetector(
          onTap: () async {
            XFile? imageFromSource;
            await showAlertDialog(context, imagePicker, (num) async {
              if (num == 0) {
                imageFromSource = await pickImageFromGallery(imagePicker);
              } else {
                imageFromSource = await pickImageFromCamera(imagePicker);
              }
            });

            if (imageFromSource != null) {
              image.value = File(imageFromSource!.path);
              widget.fun(image.value);
            }
          },
          child: AspectRatio(
            aspectRatio: 1.5,
            child: ValueListenableBuilder(
              valueListenable: image,
              builder: (context, path, child) {
                return DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: Radius.circular(rem(1.4)),
                    dashPattern: [10, 5],
                  ),
                  child: path == null
                      ? CaseNotUploadImage()
                      : CaseUploadImage(path: path),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CaseUploadImage extends StatelessWidget {
  final File path;
  const CaseUploadImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: FileImage(path), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(rem(1.4)),
      ),
    );
  }
}

class CaseNotUploadImage extends StatelessWidget {
  const CaseNotUploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: rem(2),
            child: Icon(Icons.upload_file_rounded, size: rem(2)),
          ),
          Text(
            "Upload ID Picture",
            style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
          ),
          Text("PNG, GPG, up to 10MB", style: TextStyle(fontSize: rem(0.8))),
        ],
      ),
    );
  }
}

class SectionGroupOfInputField extends StatelessWidget {
  const SectionGroupOfInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isSecure = ValueNotifier<bool>(false);
    return Column(
      spacing: rem(1),
      children: [
        InputFieldForm(
          name: phoneKey,
          hintText: "+963*********",
          labelTeaxt: "Phone No",
          textInputType: TextInputType.phone,
          validatorsProps: [
            FormBuilderValidators.phoneNumber(
              regex: RegExp(r"^\+963[0-9]{9}$"),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: isSecure,
          builder: (context, value, child) {
            return InputFieldForm(
              name: passwordKey,
              hintText: "********",
              labelTeaxt: toCapitalize(passwordKey),
              suffixIcon: IconButton(
                onPressed: () {
                  isSecure.value = !isSecure.value;
                },
                icon: Icon(
                  isSecure.value ? Icons.visibility_off : Icons.remove_red_eye,
                ),
              ),
              obscureText: !isSecure.value,
              validatorsProps: [FormBuilderValidators.password()],
            );
          },
        ),
        InputFieldForm(
          name: firstNameKey,
          hintText: "Motaz",
          labelTeaxt: toCapitalize(firstNameKey),
          validatorsProps: [FormBuilderValidators.firstName()],
        ),
        InputFieldForm(
          name: lastNameKey,
          hintText: "Abo Assi",
          labelTeaxt: toCapitalize(lastNameKey),
          validatorsProps: [FormBuilderValidators.lastName()],
        ),
        FormBuilderDateTimePicker(
          inputType: InputType.date,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          format: DateFormat('dd-MM-yyyy'),
          decoration: decorationInputFieldLogin(
            hintText: "select your date of birth",
            labelTeaxt: dateOfBirthKey,
          ),

          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          name: dateOfBirthKey,
          firstDate: DateTime(1990, 1, 1),
          lastDate: DateTime(5000),
        ),
      ],
    );
  }
}

class SectionImagePickerProfile extends StatefulWidget {
  const SectionImagePickerProfile({
    super.key,
    required this.constraints,
    required this.fun,
  });

  final BoxConstraints constraints;
  final VoidCallBackFile fun;

  @override
  State<SectionImagePickerProfile> createState() =>
      _SectionImagePickerProfileState();
}

class _SectionImagePickerProfileState extends State<SectionImagePickerProfile> {
  final ImagePicker imagePicker = ImagePicker();
  ValueNotifier<File?> image = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    const double radiusProfile = 4;
    const double radiusIcon = 1.3;
    return Column(
      children: [
        ValueListenableBuilder<File?>(
          valueListenable: image,
          builder: (context, path, child) {
            return Stack(
              children: [
                Align(
                  child: CircleAvatar(
                    radius: rem(radiusProfile),
                    backgroundColor: Colors.red,
                    child: CircleAvatar(
                      radius: rem(radiusProfile - 0.1),
                      backgroundImage: path == null
                          ? AssetImage(anonymousManAvatar)
                          : FileImage(path),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: widget.constraints.maxWidth * 0.3,
                  child: CircleAvatar(
                    backgroundColor: thirdly,
                    radius: rem(radiusIcon + 0.1),
                    child: CircleAvatar(
                      backgroundColor: fourthly,
                      radius: rem(radiusIcon - 0.1),
                      child: GestureDetector(
                        onTap: () async {
                          XFile? imageFromSource;
                          await showAlertDialog(context, imagePicker, (
                            num,
                          ) async {
                            if (num == 0) {
                              imageFromSource = await pickImageFromGallery(
                                imagePicker,
                              );
                            } else {
                              imageFromSource = await pickImageFromCamera(
                                imagePicker,
                              );
                            }
                          });

                          if (imageFromSource != null) {
                            image.value = File(imageFromSource!.path);
                            widget.fun(image.value);
                          }
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          color: thirdly,
                          size: rem(radiusIcon * 1.1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Center(
          child: Text(
            "Add Profile Picture",
            style: TextStyle(fontSize: rem(1), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({super.key});

  @override
  State<ImagePickerExample> createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image != null
              ? Image.network(_image!.path, height: 200)
              : const Text('No image selected'),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: pickImageFromGallery,
            child: const Text('Pick from Gallery'),
          ),

          ElevatedButton(
            onPressed: pickImageFromCamera,
            child: const Text('Pick from Camera'),
          ),
        ],
      ),
    );
  }
}





      // home: Scaffold(
      //   body: FutureBuilder(
      //     // future: HttpRequest().logout(),
      //     // future: HttpRequest().login(
      //     //   UserLoginType(phone: "10000000", password: "00000000"),
      //     // ),
      //     future: HttpRequest().bookingsApartmentByID(0),
      //     builder: (context, asyncSnapshot) {
      //       if (asyncSnapshot.hasData) {
      //         return Center(child: Text(asyncSnapshot.data?.city ?? "null"));
      //       } else {
      //         return Center(child: Text(asyncSnapshot.error.toString()));
      //       }
      //     },
      //   ),
      // ),
