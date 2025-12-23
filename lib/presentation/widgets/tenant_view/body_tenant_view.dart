import 'package:booking/data/sections/tenant_view/section_most_popular.dart';
import 'package:booking/data/sections/tenant_view/section_search_and_filter.dart';
import 'package:booking/data/sections/tenant_view/section_search_in.dart';
import 'package:booking/presentation/cubit/tenant_view/tenant_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyTenantView extends StatelessWidget {
  const BodyTenantView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (BuildContext context) => TenantViewCubit(),
        child: CustomScrollView(
          slivers: [
            // SectionSearchAndFilter(),
            SectionMostPopular(),
            SectionSearchIn(),
          ],
        ),
      ),
    );
  }
}
