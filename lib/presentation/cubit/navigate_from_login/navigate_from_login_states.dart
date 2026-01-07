class NavigateFromLoginStates {
  final String? role;

  NavigateFromLoginStates({required this.role});
}

class NavigateInitial extends NavigateFromLoginStates {
  NavigateInitial({required super.role});
}

class NavigateLoading extends NavigateFromLoginStates {
  NavigateLoading({ super.role = ""});
}
class NavigateTo extends NavigateFromLoginStates {
  NavigateTo({required super.role});
}
