import '../../utils/basic_widget_imports.dart';

class OutsideClickListener extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const OutsideClickListener({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.transparent,
          ),
        ),
        child,
      ],
    );
  }
}