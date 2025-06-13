part of 'generic_widgets.dart';

class ImageNetworkWidget extends StatefulWidget {
  const ImageNetworkWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.color,
    this.colorBlendMode,
    this.alignment = Alignment.center,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final Color? color;
  final BlendMode? colorBlendMode;
  final AlignmentGeometry alignment;

  @override
  State<ImageNetworkWidget> createState() => _ImageNetworkWidgetState();
}

class _ImageNetworkWidgetState extends State<ImageNetworkWidget> {
  bool _hasError = false;
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isLoaded && !_hasError) {
          _showFullScreenImageDialog(context, widget.imageUrl);
        }
      },
      child: Image.network(
        widget.imageUrl,
        height: widget.height,
        width: widget.width,
        color: widget.color,
        colorBlendMode: widget.colorBlendMode,
        fit: BoxFit.cover,
        alignment: widget.alignment,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            if (!_isLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _isLoaded = true;
                  });
                }
              });
            }
            return child;
          } else {
            return ShimmerWidget.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(color: AppColorTheme().white),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          if (!_hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _hasError = true;
                });
              }
            });
          }
          return Container(
            height: widget.height,
            width: widget.width,
            color: AppColorTheme().lightGrey,
            child: Center(
              child: Icon(
                AppIcons().imageError,
                color: AppColorTheme().darkGrey,
                size: 60,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFullScreenImageDialog(BuildContext context, String imageUrl) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColorTheme().black,
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      },
      pageBuilder: (
        BuildContext buildContext,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Stack(
          children: [
            Image.network(
              imageUrl,
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    AppIcons().imageError,
                    color: AppColorTheme().darkGrey,
                    size: 60,
                  ),
                );
              },
            ),
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () => context.popPage(),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColorTheme().black.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      AppIcons().close,
                      color: AppColorTheme().white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
