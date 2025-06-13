part of 'view.dart';

class UserRootPage extends StatelessWidget {
  const UserRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserRootCubit>(create: (context) => UserRootCubit()),
        BlocProvider<CollectionCubit>(
                    create: (context) => CollectionCubit(
            CollectionRepository(
              cacheClient: CacheClient(),
              connectivity: Connectivity(),
            ),
          ),
          
        ),
      ],
      child: const _UserRootView(),
    );
  }
}

class _UserRootView extends StatelessWidget {
  const _UserRootView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _RootViewPages(),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _RootViewPages extends StatelessWidget {
  const _RootViewPages();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRootCubit, UserRootState>(
      buildWhen: (previous, current) =>
          previous.navBarItem != current.navBarItem,
      builder: (context, state) {
        return IndexedStack(
          index: _buildPageIndex(state),
          children: const [
            Placeholder(),
            MyCollectionPage(),
            Placeholder(),
            Placeholder(),
          ],
        );
      },
    );
  }

  int _buildPageIndex(UserRootState state) {
    switch (state.navBarItem) {
      case NavBarItem.scan:
        return 0;
      case NavBarItem.collection:
        return 1;
      case NavBarItem.shop:
        return 2;
      case NavBarItem.settings:
        return 3;
    }
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRootCubit, UserRootState>(
      buildWhen: (previous, current) =>
          previous.navBarItem != current.navBarItem,
      builder: (context, state) {
        return BottomNavBarWidget(
          currentIndex: state.navBarItem.index,
          onTapScan: () =>
              context.read<UserRootCubit>().getNavBarItem(NavBarItem.scan),
          onTapCollection: () => context.read<UserRootCubit>().getNavBarItem(
            NavBarItem.collection,
          ),
          onTapShop: () =>
              context.read<UserRootCubit>().getNavBarItem(NavBarItem.shop),
          onTapSettings: () =>
              context.read<UserRootCubit>().getNavBarItem(NavBarItem.settings),
        );
      },
    );
  }
}
