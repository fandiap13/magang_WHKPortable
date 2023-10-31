import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/services/sensor_service.dart';

class DeviceCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final IconData icon;
  final VoidCallback? onTapFunction;
  final int? duration;

  const DeviceCard({
    required this.imageUrl,
    required this.title,
    required this.icon,
    this.onTapFunction,
    this.duration,
    super.key,
  });

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> with TickerProviderStateMixin {
  final sensorService = Get.put(SensorService());
  AnimationController? _fadeInController;
  AnimationController? _slideController;
  Animation<double>? _animationFadeIn;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    var duration = widget.duration;

    _fadeInController = AnimationController(
        vsync: this, duration: Duration(milliseconds: (duration as int) * 2));
    _slideController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));

    _animationFadeIn =
        Tween<double>(begin: 0, end: 1).animate(_fadeInController!);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Start off the screen (top)
      end: const Offset(0, 0), // End position (center of the screen)
    ).animate(CurvedAnimation(
      parent: _slideController!,
      curve: Curves.easeInOut,
    ));

    _slideController!.forward();
    _fadeInController!.forward();
  }

  @override
  void dispose() {
    _slideController!.dispose();
    _fadeInController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation!,
      child: FadeTransition(
        opacity: _animationFadeIn!,
        child: GestureDetector(
          onTap: widget.onTapFunction,
          child: Card(
            margin: const EdgeInsets.only(bottom: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      widget.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          color: AppColors.secondaryColor),
                    ),
                    trailing: Icon(
                      widget.icon,
                      size: 30.0,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
