part of 'views.dart';

class MyCollectionPage extends StatefulWidget {
  const MyCollectionPage({super.key});

  @override
  State<MyCollectionPage> createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySub;

  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    context.read<CollectionCubit>().getCollection();

    _connectivitySub = _connectivity.onConnectivityChanged.listen((result) {
      bool online = !result.contains(ConnectivityResult.none);

      if (mounted) {
        context.showSnackbar(online ? 'You are online' : 'You are offline');
      }
    });
  }

  @override
  void dispose() {
    _connectivitySub.cancel();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() => _searchQuery = null);
    await context.read<CollectionCubit>().getCollection();
  }

  void _onSearchChanged(String text) {
    setState(() => _searchQuery = text.trim());
    context.read<CollectionCubit>().filterCollection(
      name: _searchQuery,
      minCount: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme().primary,
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER ─────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
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
            ),

            // ── SEARCH BAR ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColorTheme().whiteShade1,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: _onSearchChanged,
                  style: TextStyle(color: AppColorTheme().primaryDark),
                  decoration: InputDecoration(
                    hintText: 'Search by name…',
                    hintStyle: TextStyle(color: AppColorTheme().grey),
                    prefixIcon: Icon(Icons.search, color: AppColorTheme().grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 16),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         decoration: BoxDecoration(
            //           color: AppColorTheme().whiteShade1,
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         child: TextField(
            //           keyboardType: TextInputType.number,
            //           onChanged: (v) {
            //             final val = int.tryParse(v) ?? 0;
            //             context.read<CollectionCubit>().filterCollection(
            //               name: _searchQuery,
            //               minCount: val > 0 ? val : null,
            //             );
            //           },
            //           decoration: InputDecoration(
            //             hintText: 'Min count',
            //             border: InputBorder.none,
            //             contentPadding: const EdgeInsets.symmetric(
            //               vertical: 14,
            //               horizontal: 16,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     IconButton(
            //       icon: const Icon(Icons.clear),
            //       onPressed: () {
            //         // clear both filters
            //         _onSearchChanged('');
            //         context.read<CollectionCubit>().filterCollection(
            //           name: null,
            //           minCount: null,
            //         );
            //       },
            //     ),
            //   ],
            // ),
            const SizedBox(height: 16),

            // ── CONTENT ─────────────────────────────────
            Expanded(
              child: BlocBuilder<CollectionCubit, CollectionState>(
                builder: (context, state) {
                  final api = state.collectionApiState;

                  if (api.apiCallState == APICallState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (api.apiCallState == APICallState.failure) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 80),
                          Center(
                            child: Text(
                              api.errorMessage ?? 'Failed to load collection',
                              style: AppTextTheme().latoBodySmallText.copyWith(
                                color: AppColorTheme().red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final bottles = api.model ?? [];
                  if (bottles.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 80),
                          Center(child: Text('No collection found')),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.6,
                          ),
                      itemCount: bottles.length,
                      itemBuilder: (ctx, i) {
                        final b = bottles[i];
                        return GestureDetector(
                          onTap: () => context.pushPage(
                            BottleDetailsPage(collectionModel: b),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColorTheme().primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    b.image ?? '',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${b.name}\n${b.year} ${b.number}',
                                  textAlign: TextAlign.center,
                                  style: AppTextTheme().ebGaramondTitleLargeText
                                      .copyWith(color: AppColorTheme().white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '(${b.count}/${b.total})',
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
