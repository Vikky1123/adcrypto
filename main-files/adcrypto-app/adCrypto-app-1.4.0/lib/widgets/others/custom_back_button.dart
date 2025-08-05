import '../../utils/basic_screen_imports.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Row(
      children: [
        horizontalSpace(isTablet()
            ? Dimensions.widthSize * .5
            : Dimensions.widthSize * 1.5),
        InkWell(
          onTap: onTap ?? () => Navigator.pop(context),
          child: CircleAvatar(
            radius: Dimensions.radius * 1.2,
            backgroundColor: CustomColor.primaryLightColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize * .3),
              child: Icon(
                Icons.arrow_back_ios,
                color: CustomColor.whiteColor,
                size: Dimensions.heightSize,
                weight: Dimensions.widthSize * 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}