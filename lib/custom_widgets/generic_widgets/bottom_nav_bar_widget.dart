part of 'generic_widgets.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key, required this.children});

  final List<BottomNavBarItemWidget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: AppColorTheme().secondary,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}

class BottomNavBarItemWidget extends StatelessWidget {
  const BottomNavBarItemWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.image,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColorTheme().primary : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              image,
              fit: BoxFit.scaleDown,
              height: 54,
              width: 54,
            ),
          ),
        ),
      ),
    );
  }
}
