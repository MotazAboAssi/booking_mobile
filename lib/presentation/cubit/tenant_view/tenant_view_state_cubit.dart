import 'package:booking/types/apartment_type.dart';

class TenantViewStateCubit {}

class TenantViewInitial extends TenantViewStateCubit {}

class TenantViewLoading extends TenantViewStateCubit {}

class TenantViewSucceeful extends TenantViewStateCubit {
  final List<ApartmentTypeForTenant> apartment;
  TenantViewSucceeful({required this.apartment});
}

class TenantViewFaild extends TenantViewStateCubit {
  final String error;

  TenantViewFaild({required this.error});
}
