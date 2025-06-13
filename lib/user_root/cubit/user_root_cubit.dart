import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_root_state.dart';

class UserRootCubit extends Cubit<UserRootState> {
  UserRootCubit() : super(const UserRootState());

  void getNavBarItem(NavBarItem navBarItem) {
    switch (navBarItem) {
      case NavBarItem.scan:
        emit(state.copyWith(navBarItem: NavBarItem.scan));
        break;
      case NavBarItem.collection:
        emit(state.copyWith(navBarItem: NavBarItem.collection));
        break;
      case NavBarItem.shop:
        emit(state.copyWith(navBarItem: NavBarItem.shop));
        break;
      case NavBarItem.settings:
        emit(state.copyWith(navBarItem: NavBarItem.settings));
        break;
    }
  }
}
