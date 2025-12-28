
import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_states.dart';
import 'package:booking/presentation/views/tenant/display_profile_user_view.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SectionLandLordProfile extends StatefulWidget {
  final ApartmentType apartment;

  const SectionLandLordProfile({super.key, required this.apartment});

  @override
  State<SectionLandLordProfile> createState() => _SectionLandLordProfileState();
}

class _SectionLandLordProfileState extends State<SectionLandLordProfile> {
  @override
  void initState() {
    final cubit = context.read<FetchUserCubit>();
    cubit.userByID(widget.apartment.idLandlord);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printRed("refresh");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        BlocBuilder<FetchUserCubit, FetchUserStates>(
          builder: (context, state) {
            if (state is FetchUserSuccessful) {
              return LandLordProfileCard(
                user: state.user,
                apartment: widget.apartment,
              );
            }
            return Skeletonizer(child: LandLordProfileCard());
          },
        ),
      ],
    );
  }
}

class LandLordProfileCard extends StatelessWidget {
  const LandLordProfileCard({super.key, this.user, this.apartment});
  final UserRegisterType? user;
  final ApartmentType? apartment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => DisplayProfileUserView(user: user),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundImage: user?.profileImage == null
                      ? AssetImage(anonymousManAvatar)
                      : fetchImageFromDB(user!.profileImage.path),
                  radius: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Owner", style: TextStyle(color: secondary)),
                    Text(
                      "${user?.firstName} ${user?.lastName}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Text(
                  '${apartment?.rating}',
                  style: TextStyle(
                    fontSize: rem(1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(" (124)"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
