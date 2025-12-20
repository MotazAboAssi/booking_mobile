import 'package:booking/presentation/cubit/tenant_view/tenant_view_state_cubit.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TenantViewCubit extends Cubit<TenantViewStateCubit> {
  TenantViewCubit() : super(TenantViewInitial());
  Future<void> getAllApartmentForTenant() async {
    try {
      emit(TenantViewLoading());
      final List<ApartmentTypeForTenant> apartments = await HttpRequest()
          .getAllApartementForTenant();
      emit(TenantViewSucceeful(apartment: apartments));
    } catch (e) {
      emit(TenantViewFaild(error: e.toString().split(":")[1]));
    }
  }
}
