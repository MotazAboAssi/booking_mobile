import 'package:booking/data/models/display_profile_user_view/card_info.dart';
import 'package:booking/data/sections/display_profile_user_view/section_group_of_input_field.dart';
import 'package:booking/data/sections/display_profile_user_view/section_image_picker_profile.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_states.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_states.dart';
import 'package:booking/presentation/widgets/custome_bottom_navigation_bar_for_landlord.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileViewLandlord extends StatefulWidget {
  const ProfileViewLandlord({super.key});
  @override
  State<ProfileViewLandlord> createState() => _ProfileViewLandlordState();
}

class _ProfileViewLandlordState extends State<ProfileViewLandlord> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<FetchUserCubit>();
    cubit.userApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomeBottomNavigationBarForLandlord(index: 1),
      appBar: AppBar(
        leading: BlocBuilder<ToggleColorCubit, ToggleColorStates>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                final cubit = BlocProvider.of<ToggleColorCubit>(context);
                cubit.toggle(context);
              },
              icon: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            style: ElevatedButton.styleFrom(iconColor: Colors.red),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetPadding: EdgeInsets.all(rem(5)),
                    child: Padding(
                      padding: EdgeInsets.all(rem(1)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Are you sure ?",
                            style: TextStyle(
                              fontSize: rem(1.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  try {
                                    await HttpRequest().logout();
                                    navigateTo(context, loginView);
                                  } catch (e) {
                                    printYallow(e.toString());
                                  }
                                },
                                child: Text("Ok"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Discard"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.logout, size: rem(2)),
          ),
        ],
        title: Text(
          "My Account",
          style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(rem(1)),
          child: BlocBuilder<FetchUserCubit, FetchUserStates>(
            builder: (context, state) {
              if (state is FetchUserSuccessful) {
                final user = state.user;
                return Center(
                  child: Column(
                    spacing: rem(1),
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        spacing: rem(1),

                        children: [
                          SectionImagePickerProfile(image: user?.profileImage),
                          SectionGroupOfInputField(user: user),
                          CardInfo(
                            icon: Icons.account_balance_wallet,
                            title: '${user?.balance.toString()} \$',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state is FetchUserFaild) {
                return Padding(
                  padding: EdgeInsets.all(rem(1)),
                  child: Center(
                    child: Text(
                      "No Internet 😢",
                      style: TextStyle(
                        fontSize: rem(2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              } else {
                return Skeletonizer(
                  child: Column(
                    spacing: rem(1),
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SectionImagePickerProfile(),
                      SectionGroupOfInputField(),
                      CardInfo(
                        icon: Icons.account_balance_wallet,
                        title: '${1000} \$',
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // CustomeBottomNavigationBarForTenant determineTypeBottomNavigationBar() {
  //   if()
  //   return CustomeBottomNavigationBarForTenant(index: 3);
  // }
}
