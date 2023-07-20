part of './widget.dart';

class ShowCountCircle extends StatelessWidget {
  const ShowCountCircle({
    Key? key,
    required this.count,
    required this.radius,
  }) : super(key: key);

  final String count;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: radius,
      backgroundColor: AppColors.darkPrimaryColor,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(count,
              style: TextStyle(
                  fontSize: 15,
                  color: AppColors.white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      // radius: 5,
    );
  }
}
