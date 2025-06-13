part of 'widgets.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTapScan,
    required this.onTapCollection,
    required this.onTapShop,
    required this.onTapSettings,
  });

  final int currentIndex;
  final VoidCallback onTapScan;
  final VoidCallback onTapCollection;
  final VoidCallback onTapShop;
  final VoidCallback onTapSettings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 16 : 0),
      decoration: BoxDecoration(
        color: AppColorTheme().primaryDark,
        border: Border(
          top: BorderSide(color: AppColorTheme().black.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavBarItem(
            icon: AppIcons().scan,
            isSelected: 0 == currentIndex,
            label: 'Scan',
            onTap: onTapScan,
          ),
          _BottomNavBarItem(
            icon: AppIcons().collection,
            isSelected: 1 == currentIndex,
            label: 'Collection',
            onTap: onTapCollection,
          ),
          _BottomNavBarItem(
            icon: AppIcons().shop,
            isSelected: 2 == currentIndex,
            label: 'Shop',
            onTap: onTapShop,
          ),
          _BottomNavBarItem(
            icon: AppIcons().settings,
            isSelected: 3 == currentIndex,
            label: 'Settings',
            onTap: onTapSettings,
          ),
        ],
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  const _BottomNavBarItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(
            opacity: isSelected ? 1 : 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isSelected
                    ? Icon(icon, color: AppColorTheme().white, size: 28)
                    : Icon(icon, color: AppColorTheme().grey, size: 28),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: AppTextTheme().latoBodySmallText.copyWith(
                    color: isSelected
                        ? AppColorTheme().white
                        : AppColorTheme().grey,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
