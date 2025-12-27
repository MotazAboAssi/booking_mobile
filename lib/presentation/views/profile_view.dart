import 'package:booking/data/models/display_profile_user_view/card_info.dart';
import 'package:booking/data/sections/display_profile_user_view/section_group_of_input_field.dart';
import 'package:booking/data/sections/display_profile_user_view/section_image_picker_profile.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_states.dart';
import 'package:booking/presentation/widgets/custome_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<FetchUserCubit>();
    cubit.userApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomeBottomNavigationBar(index: 3),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(rem(1)),
              child: BlocBuilder<FetchUserCubit, FetchUserStates>(
                builder: (context, state) {
                  if (state is FetchUserSuccessful) {
                    final user = state.user;
                    return Column(
                      spacing: rem(1),
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SectionImagePickerProfile(image: user?.profileImage),
                        SectionGroupOfInputField(user: user),
                        CardInfo(
                          icon: Icons.account_balance_wallet,
                          title: '${user?.balance.toString()} \$',
                        ),
                      ],
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
          ],
        ),
      ),
    );
  }
}
