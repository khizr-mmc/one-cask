part of 'views.dart';

class BottleDetailsPage extends StatefulWidget {
  final CollectionModel? collectionModel;
  const BottleDetailsPage({super.key, this.collectionModel});

  @override
  State<BottleDetailsPage> createState() => _BottleDetailsPageState();
}

class _BottleDetailsPageState extends State<BottleDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['Details', 'Tasting notes', 'History'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildCustomTabBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColorTheme().primaryDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool selected = _tabController.index == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                _tabController.animateTo(index);
                setState(() {});
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColorTheme().secondary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: AppTextTheme().latoBodySmallText.copyWith(
                    color: selected
                        ? AppColorTheme().primary
                        : AppColorTheme().grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildDetailsTable() {
    final details = [
      {'label': 'Distillery', 'value': 'Text'},
      {'label': 'Region', 'value': 'Text'},
      {'label': 'Country', 'value': 'Text'},
      {'label': 'Type', 'value': 'Text'},
      {'label': 'Age statement', 'value': 'Text'},
      {'label': 'Filled', 'value': 'Text'},
      {'label': 'Bottled', 'value': 'Text'},
      {'label': 'Cask number', 'value': 'Text'},
      {'label': 'ABV', 'value': 'Text'},
      {'label': 'Size', 'value': 'Text'},
      {'label': 'Finish', 'value': 'Text'},
    ];

    return Column(
      children: details
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item['label']!,
                      style: AppTextTheme().latoBodySmallText.copyWith(
                        color: AppColorTheme().grey,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      item['value']!,
                      style: AppTextTheme().latoBodySmallText.copyWith(
                        color: AppColorTheme().white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildTastingCard(String title, List<String> descriptions) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorTheme().primaryDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextTheme().ebGaramondTitleLargeText.copyWith(
              color: AppColorTheme().white,
            ),
          ),
          const SizedBox(height: 8),
          ...descriptions.map(
            (desc) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                desc,
                style: AppTextTheme().latoBodySmallText.copyWith(
                  color: AppColorTheme().white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTastingNotesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video placeholder
        Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: AppColorTheme().primaryDark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(Icons.play_arrow, color: Colors.white, size: 48),
          ),
        ),
        const SizedBox(height: 20),
        // Tasting notes by
        Text(
          'Tasting notes',
          style: AppTextTheme().ebGaramondTitleLargeText.copyWith(
            color: AppColorTheme().white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'by Charles MacLean MBE',
          style: AppTextTheme().latoBodySmallText.copyWith(
            color: AppColorTheme().grey,
          ),
        ),
        const SizedBox(height: 12),
        // Tasting cards
        buildTastingCard('Nose', ['Description', 'Description', 'Description']),
        buildTastingCard('Palate', [
          'Description',
          'Description',
          'Description',
        ]),
        buildTastingCard('Finish', [
          'Description',
          'Description',
          'Description',
        ]),
        const SizedBox(height: 16),
        // Your notes header
        Row(
          children: [
            Text(
              'Your notes',
              style: AppTextTheme().ebGaramondTitleLargeText.copyWith(
                color: AppColorTheme().white,
              ),
            ),
            const Spacer(),
            Icon(AppIcons().backArrow, color: AppColorTheme().white, size: 18),
          ],
        ),
        const SizedBox(height: 12),
        // Your notes cards
        buildTastingCard('Nose', ['Description', 'Description', 'Description']),
        buildTastingCard('Palate', [
          'Description',
          'Description',
          'Description',
        ]),
        buildTastingCard('Finish', [
          'Description',
          'Description',
          'Description',
        ]),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildAttachmentRow() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColorTheme().primaryDark,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                AppIcons().attachFile,
                color: AppColorTheme().white,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Attachments',
                style: AppTextTheme().latoBodySmallText.copyWith(
                  color: AppColorTheme().white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              3,
              (index) => Container(
                width: 48,
                height: 48,
                margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                decoration: BoxDecoration(
                  color: AppColorTheme().primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Updated History Tab ---
  Widget buildHistoryTab() {
    final historyEvents = [
      {
        'label': 'Label',
        'title': 'Title',
        'descriptions': ['Description', 'Description'],
      },
      {
        'label': 'Label',
        'title': 'Title',
        'descriptions': ['Description', 'Description'],
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColorTheme().primaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: List.generate(historyEvents.length, (index) {
              final isLast = index == historyEvents.length - 1;
              return Column(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColorTheme().white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColorTheme().primaryDark,
                        width: 2,
                      ),
                    ),
                  ),
                  // White circle
                  if (index == 0) Container(height: 0),
                  if (!isLast)
                    Column(
                      children: [
                        // Vertical line
                        Container(
                          width: 2,
                          height: context.mHeight * 0.12,
                          color: AppColorTheme().secondary,
                        ),
                        // Top small diamond
                        Transform.rotate(
                          angle: 0.785398, // 45 degrees in radians
                          child: Container(
                            width: 4,
                            height: 4,
                            color: AppColorTheme().secondary,
                          ),
                        ),
                        // Vertical line
                        Container(
                          width: 2,
                          height: 4,
                          color: AppColorTheme().secondary,
                        ),
                        // Middle large diamond
                        Transform.rotate(
                          angle: 0.785398, // 45 degrees in radians
                          child: Container(
                            width: 8,
                            height: 8,
                            color: AppColorTheme().secondary,
                          ),
                        ),
                        // Vertical line
                        Container(
                          width: 2,
                          height: 4,
                          color: AppColorTheme().secondary,
                        ),
                        // Bottom small diamond
                        Transform.rotate(
                          angle: 0.785398, // 45 degrees in radians
                          child: Container(
                            width: 4,
                            height: 4,
                            color: AppColorTheme().secondary,
                          ),
                        ),
                        // vertical line
                        Container(
                          width: 2,
                          height: context.mHeight * 0.12,
                          color: AppColorTheme().secondary,
                        ),
                      ],
                    ),
                ],
              );
            }),
          ),
          const SizedBox(width: 16),
          // Cards
          Expanded(
            child: Column(
              spacing: 12,
              children: List.generate(historyEvents.length, (index) {
                final event = historyEvents[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      event['label'] as String,
                      style: AppTextTheme().latoBodySmallText.copyWith(
                        color: AppColorTheme().grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event['title'] as String,
                      style: AppTextTheme().ebGaramondHeadingLargeText.copyWith(
                        color: AppColorTheme().white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...((event['descriptions'] as List<String>).map(
                      (desc) => Text(
                        desc,
                        style: AppTextTheme().latoBodySmallText.copyWith(
                          color: AppColorTheme().white,
                        ),
                      ),
                    )),
                    // Attachments
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColorTheme().primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                AppIcons().attachFile,
                                color: AppColorTheme().white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Attachments',
                                style: AppTextTheme().latoBodySmallText
                                    .copyWith(color: AppColorTheme().white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(
                              3,
                              (i) => Container(
                                width: 48,
                                height: 48,
                                margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                                decoration: BoxDecoration(
                                  color: AppColorTheme().whiteShade1,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  // --- End Updated History Tab ---

  @override
  Widget build(BuildContext context) {
    final bottle = widget.collectionModel;
    return Scaffold(
      backgroundColor: AppColorTheme().primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Transform.scale(
            scale: 1.2,
            child: Image.asset(AppImages.background, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header (fixed)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Genesis Collection',
                          style: AppTextTheme().latoBodySmallText.copyWith(
                            color: AppColorTheme().white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          AppIcons().close,
                          color: AppColorTheme().white,
                        ),
                        onPressed: () => context.popPage(),
                      ),
                    ],
                  ),
                ),
                // Expanded scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Sub-header
                        const SizedBox(height: 16),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColorTheme().primaryDark,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.genuineIcon,
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Genuine Bottle (Unopened)',
                                  style: AppTextTheme().latoBodySmallText
                                      .copyWith(color: AppColorTheme().white),
                                ),
                              ),
                              Icon(
                                AppIcons().keyboardArrowDown,
                                color: AppColorTheme().secondary,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Bottle image
                        Center(
                          child: Image.asset(
                            bottle?.image ?? 'assets/images/bottle.png',
                            height: context.mHeight * 0.35,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Main content container
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColorTheme().primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Bottle info
                                Text(
                                  'Bottle: ${bottle?.number ?? "###"}',
                                  style: AppTextTheme().latoBodySmallText
                                      .copyWith(color: AppColorTheme().grey),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      bottle?.name ?? 'Talisker',
                                      style: AppTextTheme()
                                          .ebGaramondHeadingLargeText
                                          .copyWith(
                                            color: AppColorTheme().white,
                                            fontSize: 30,
                                          ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '18 Year old',
                                      style: AppTextTheme()
                                          .ebGaramondHeadingLargeText
                                          .copyWith(
                                            color: AppColorTheme().secondary,
                                            fontSize: 30,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                Text(
                                  '#${bottle?.number ?? "2504"}',
                                  style: AppTextTheme().ebGaramondTitleLargeText
                                      .copyWith(color: AppColorTheme().white),
                                ),
                                const SizedBox(height: 20),
                                // Custom Tab bar
                                buildCustomTabBar(),
                                const SizedBox(height: 16),
                                // Tab content
                                Builder(
                                  builder: (context) {
                                    if (_tabController.index == 0) {
                                      return buildDetailsTable();
                                    } else if (_tabController.index == 1) {
                                      return buildTastingNotesTab();
                                    } else {
                                      return buildHistoryTab();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Add to my collection button
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: CustomElevatedButton(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            width: context.mWidth * 0.6,
                            onTap: () {},
                            buttonColor: AppColorTheme().secondary,
                            radius: 8,
                            fontColor: AppColorTheme().black,
                            title: 'Add to my collection',
                            hasIcon: true,
                            icon: AppIcons().add,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
