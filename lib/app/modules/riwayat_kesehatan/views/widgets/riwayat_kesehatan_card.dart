import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/device_icon_component.dart';

class RiwayatKesehatanCard extends StatefulWidget {
  final int id;
  final String title;
  final IconData icon;
  final String tanggal;
  final String status;
  final String jam;
  final Map<String, dynamic> value1;
  final Map<String, dynamic>? value2;
  final VoidCallback? onTap;
  final int? durationMiliSec;

  const RiwayatKesehatanCard(
      {super.key,
      required this.id,
      required this.title,
      required this.icon,
      required this.tanggal,
      required this.status,
      required this.jam,
      required this.value1,
      required this.onTap,
      this.durationMiliSec,
      this.value2});

  @override
  State<RiwayatKesehatanCard> createState() => _RiwayatKesehatanCardState();
}

class _RiwayatKesehatanCardState extends State<RiwayatKesehatanCard>
    with TickerProviderStateMixin {
  AnimationController? _fadeInController;
  AnimationController? _slideController;
  Animation<double>? _animationFadeIn;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    var duration = widget.durationMiliSec;

    _fadeInController = AnimationController(
        vsync: this, duration: Duration(milliseconds: (duration as int) * 2));
    _slideController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));

    _animationFadeIn =
        Tween<double>(begin: 0, end: 1).animate(_fadeInController!);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start off the screen (top)
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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DeviceIconComponent(icon: widget.icon, title: widget.title),
                const SizedBox(
                  height: 10.0,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Pengukuran Terakhir",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: AppColors.secondaryColor)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.tanggal,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: AppColors.secondaryColor)),
                      Text(widget.jam,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: AppColors.grey))
                    ],
                  )
                ]),
                const SizedBox(
                  height: 20.0,
                ),
                Text(StringUtils.capitalize(widget.status),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: widget.status.toLowerCase() == 'normal'
                            ? AppColors.green
                            : AppColors.dangerColor)),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.value1['title'],
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: AppColors.grey)),
                        Row(
                          children: [
                            Text("${widget.value1['value']} ",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25.0,
                                    color: AppColors.secondaryColor)),
                            Text(widget.value1['satuan'],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: AppColors.secondaryColor)),
                          ],
                        )
                      ],
                    ),
                    Builder(builder: (context) {
                      if (widget.value2.isNull) {
                        return const Text("");
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.value2!['title'],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                  color: AppColors.grey)),
                          Row(
                            children: [
                              Text("${widget.value2!['value']} ",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25.0,
                                      color: AppColors.secondaryColor)),
                              Text(widget.value2!['satuan'],
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: AppColors.secondaryColor)),
                            ],
                          )
                        ],
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton.icon(
                    style: const ButtonStyle(
                        iconColor:
                            MaterialStatePropertyAll(AppColors.primaryColor),
                        foregroundColor:
                            MaterialStatePropertyAll(AppColors.primaryColor),
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    onPressed: widget.onTap,
                    icon: const Text(
                      "Lihat Semua",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    label: const Icon(
                      Icons.arrow_forward_outlined,
                      size: 20.0,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
