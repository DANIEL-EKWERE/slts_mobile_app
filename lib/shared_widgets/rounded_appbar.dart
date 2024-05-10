import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
    final String name;
    final String lastLogin;
    final String location;

  const RoundedAppBar({super.key, required this.name, required this.lastLogin, required this.location});
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: LayoutBuilder(builder: (context, constraint) {
     //   final width = constraint.maxWidth * 8;
        return ClipRect(
          child: OverflowBox(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 20),
              decoration: BoxDecoration(
                image: const DecorationImage(image: AssetImage(ImageAssets.header),
                 fit: BoxFit.cover,
                 ),
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r))),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget(text: 'Welcome, $name', style: getSemiBoldStyle(
                          color: white, fontSize: 24.sp
                        )),
                         SizedBox(height: 8.sp,),
                        textWidget(text: 'Last login: $lastLogin', style: getLightStyle(
                        color: grey2)),
                        SizedBox(height: 4.sp,),
                        Row(
                          children: [
                            SvgPicture.asset(ImageAssets.location),
                            SizedBox(width: 4.sp,),
                            textWidget(text: location, style: getLightStyle(
                        color: grey2)),
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      ImageAssets.lastma1,
                      height: 40.sp,
                      width: 40.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(164.0);
}
