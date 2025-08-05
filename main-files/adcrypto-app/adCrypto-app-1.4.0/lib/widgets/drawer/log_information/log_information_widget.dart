
import '../../../utils/basic_screen_imports.dart';

class LogInformationWidget extends StatelessWidget {
  const LogInformationWidget({
    super.key,
    required this.variable,
    required this.value,
    this.stoke = true,
  });
  final String variable, value;
  final bool stoke;
  @override
  Widget build(BuildContext context) {
    return Container(color:CustomColor.secondaryLightColor.withOpacity(.08),
      child: Column(
        children: [
          verticalSpace(Dimensions.heightSize * 0.7),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Expanded(
                flex: 5,
                child: TitleHeading4Widget(
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  text: variable,
                  fontSize: Dimensions.headingTextSize3 ,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.primaryLightTextColor.withOpacity(0.5),
                ),
              ),
              TitleHeading4Widget(
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                text: value,
                fontSize: Dimensions.headingTextSize3 ,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          verticalSpace(Dimensions.heightSize * 0.89),
          Visibility(
              visible: stoke,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: CustomColor.transparentColor.withOpacity(.6),
                  child: const DottedDivider()))
        ],
      ),
    );
  }
}

class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: Colors.grey.withOpacity(.5), // Set the color of the dotted border
        strokeWidth: 1.0, // Set the width of the dotted border
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    const double dashWidth = 3; // Adjust the width of the dashes
    const double dashSpace = 2; // Adjust the space between the dashes
    const double startY = 0;

    double currentX = 0;
    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, startY),
        Offset(currentX + dashWidth, startY),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}