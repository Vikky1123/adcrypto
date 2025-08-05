import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';

class CoinLogoWidget extends StatelessWidget {
  const CoinLogoWidget(
      {super.key,
      this.height,
      this.width,
      required this.networkLogoPath,
        this.assetLogoPath = ""});

  final double? height;
  final double? width;
  final String networkLogoPath;
  final String assetLogoPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius * 20)),
      child: FadeInImage(
        height: height ?? MediaQuery.of(context).size.height * .15,
        width: width,
        alignment: Alignment.center,
        fit: BoxFit.cover,
        image: NetworkImage(networkLogoPath),
        placeholder: AssetImage(assetLogoPath.isNotEmpty
            ? assetLogoPath
            : Assets.logo.appLauncher.path),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
              assetLogoPath.isNotEmpty
                  ? assetLogoPath
                  : Assets.logo.appLauncher.path,
              height: height ?? MediaQuery.of(context).size.height * .15,
              fit: BoxFit.cover);
        },
      ),
    ).paddingOnly(right: 10);
  }
}
