import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish/app/resources/colors/app_colors.dart';
import 'package:wish/app/resources/components/device_icon_component.dart';

class CardHome extends StatefulWidget {
  final String title;
  final IconData icon;
  final String tanggal;
  final String jam;
  final String status;
  final List<dynamic> hasilPengecekan;
  final VoidCallback? onTap;

  const CardHome({
    required this.title,
    required this.icon,
    required this.tanggal,
    required this.jam,
    required this.status,
    required this.hasilPengecekan,
    this.onTap,
    super.key,
  });

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // Durasi animasi
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _zoomIn() {
    _controller!.forward();
    setState(() {
      _scale = 1.05; // Faktor perbesaran
    });
  }

  void _zoomOut() {
    _controller!.reverse();
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _zoomIn,
      onLongPressEnd: (details) => _zoomOut(),
      onTap: () {},
      child: ScaleTransition(
        scale: _controller!.drive(Tween<double>(
          begin: 1.0,
          end: 1.05,
        )),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey2.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              DeviceIconComponent(icon: widget.icon, title: widget.title),
              const SizedBox(
                height: 10.0,
              ),
              // Tanggal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.tanggal,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: AppColors.dark),
                  ),
                  Text(
                    widget.jam,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: AppColors.grey),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),

              // Status
              Text(
                StringUtils.capitalize(widget.status),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: widget.status.toLowerCase().toString() == "normal"
                        ? AppColors.lightGreen
                        : AppColors.dangerColor),
              ),
              const SizedBox(
                height: 5.0,
              ),

              // Isi
              SizedBox(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var data in widget.hasilPengecekan)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'],
                              style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text(
                                  data['value'],
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryColor),
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 100),
                                    child: Text(data['satuan'],
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondaryColor)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),

              // Footer
              GestureDetector(
                onTap: widget.onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lihat Semua",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                          fontSize: 16.0),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColors.primaryColor,
                      size: 20.0,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
