part of 'user_root_cubit.dart';

enum NavBarItem { scan ,collection,shop,settings}

class UserRootState extends Equatable {
  const UserRootState({
    this.navBarItem = NavBarItem.collection,
  });

  final NavBarItem navBarItem;

  UserRootState copyWith({
    NavBarItem? navBarItem,
  }) =>
      UserRootState(
        navBarItem: navBarItem ?? this.navBarItem,
      );

  @override
  List<Object> get props => [navBarItem];
}
