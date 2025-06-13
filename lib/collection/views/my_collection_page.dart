part of 'views.dart';

class MyCollectionPage extends StatefulWidget {
  const MyCollectionPage({super.key});

  @override
  State<MyCollectionPage> createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySub;

  @override
  void initState() {
    super.initState();
    // initial load
    context.read<CollectionCubit>().getCollection();

    // listen to connectivity changes
    _connectivitySub = _connectivity.onConnectivityChanged.listen((result) {
      final isOnline = !result.contains(ConnectivityResult.none);
      if (!mounted) return;

      context.showSnackbar(isOnline ? 'You are online' : 'You are offline');
    });
  }

  @override
  void dispose() {
    _connectivitySub.cancel();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context.read<CollectionCubit>().getCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme().primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Text(
                  'My Collection',
                  style: AppTextTheme().ebGaramondHeadingLargeText.copyWith(
                    color: AppColorTheme().white,
                  ),
                ),
                const Spacer(),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        AppIcons().notification,
                        color: AppColorTheme().white,
                        size: 28,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 27,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColorTheme().red,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColorTheme().primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<CollectionCubit, CollectionState>(
                builder: (context, state) {
                  final apiState = state.collectionApiState;

                  // Loading state
                  if (apiState.apiCallState == APICallState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Failure state with retry
                  if (apiState.apiCallState == APICallState.failure) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Center(
                            heightFactor: 8,
                            child: Text(
                              apiState.errorMessage ??
                                  'Failed to load collection',
                              style: AppTextTheme().latoBodySmallText.copyWith(
                                color: AppColorTheme().red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Loaded state
                  final bottles = apiState.model ?? [];
                  if (bottles.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          Center(
                            heightFactor: 8,
                            child: Text('No collection found'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Success: grid with pull-to-refresh
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: bottles.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.6,
                          ),
                      itemBuilder: (context, index) {
                        final bottle = bottles[index];
                        return GestureDetector(
                          onTap: () {
                            context.pushPage(
                              BottleDetailsPage(collectionModel: bottle),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColorTheme().primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    bottle.image ?? '',
                                    height: 140,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '${bottle.name}\n${bottle.year} ${bottle.number}',
                                  textAlign: TextAlign.center,
                                  style: AppTextTheme().ebGaramondTitleLargeText
                                      .copyWith(color: AppColorTheme().white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '(${bottle.count}/${bottle.total})',
                                  style: AppTextTheme().latoBodySmallText
                                      .copyWith(color: AppColorTheme().grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
