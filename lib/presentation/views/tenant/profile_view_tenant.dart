import 'package:booking/data/models/display_profile_user_view/card_info.dart';
import 'package:booking/data/sections/display_profile_user_view/section_group_of_input_field.dart';
import 'package:booking/data/sections/display_profile_user_view/section_image_picker_profile.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_states.dart';
import 'package:booking/presentation/cubit/locale/locale_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_states.dart';
import 'package:booking/presentation/widgets/custome_bottom_navigation_bar_for_tenant.dart';
import 'package:booking/services/http_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileViewTenant extends StatefulWidget {
  const ProfileViewTenant({super.key});
  @override
  State<ProfileViewTenant> createState() => _ProfileViewTenantState();
}

class _ProfileViewTenantState extends State<ProfileViewTenant> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<FetchUserCubit>();
    cubit.userApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomeBottomNavigationBarForTenant(index: 3),
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.3,
        leading: Row(children: [ButtonMode(), ButtonLocalization()]),
        actions: [
          IconButton(
            style: ElevatedButton.styleFrom(iconColor: context.appTheme.error),
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
                            AuthKeys.logoutConfirmQuestion.tr(),
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
                                child: Text(AuthKeys.logoutButtonOk.tr()),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(AuthKeys.logoutButtonDiscard.tr()),
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
          TenantKeys.profilePageTitle.tr(),
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

class ButtonMode extends StatelessWidget {
  const ButtonMode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleColorCubit, ToggleColorStates>(
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
    );
  }
}

class ButtonLocalization extends StatelessWidget {
  const ButtonLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            BlocProvider.of<LocaleCubit>(context).toggleLanguage(context);
          },
          icon: Icon(Icons.language, color: context.appTheme.primarye),
        );
      },
    );
  }
}
