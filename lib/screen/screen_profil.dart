import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2/app/source.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';

class ScreenProfil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<ScreenProfil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          // Container(
          //   child: CachedNetworkImage(
          //     useOldImageOnUrlChange: true,
          //     imageUrl: "${DataSource.imgUrl}${'default'}$extantion",
          //     errorWidget: (context, url, error) => Icon(Icons.error),
          //     fit: BoxFit.cover,
          //     placeholder: (context, url) => SpinKitCircle(
          //       duration: Duration(seconds: 3),
          //       color: AppTheme.redColor,
          //       size: 25,
          //     ),
          //     imageBuilder: (context, imageProvider) {
          //       return Container(
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           image: DecorationImage(
          //             image: imageProvider,
          //             fit: BoxFit.scaleDown,
          //             colorFilter: ColorFilter.mode(
          //               Colors.white,
          //               BlendMode.colorBurn,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //     height: 130,
          //     width: 130,
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          UserCustom(
            icon: Icons.home_filled,
            title: "Entreprise",
            color: Colors.brown,
            data: Constantes.listUserConnecter[0]['nom'] ?? "A/N",
          ),
          Divider(),
          UserCustom(
            icon: Icons.phone_callback_outlined,
            title: "Téléphone",
            color: AppTheme.blueColor,
            data: Constantes.listUserConnecter[0]['tel'] ?? null,
          ),
          Divider(),
          UserCustom(
            icon: Icons.email_outlined,
            title: "E-mail",
            color: AppTheme.blueColor,
            data: Constantes.listUserConnecter[0]['email'] ?? "A/N",
          ),
          Divider(),
          UserCustom(
            icon: Icons.ad_units,
            title: "Fonction",
            color: Colors.teal,
            data: Constantes.listUserConnecter[0]['fonction'] ?? "A/N",
          ),
          Divider(),
          UserCustom(
            icon: Icons.home_outlined,
            title: "Adresse complète",
            color: Colors.black,
            data: Constantes.listUserConnecter[0]['adresse'] ?? "A/N",
          ),
          Divider(),
          UserCustom(
            icon: Icons.functions_outlined,
            title: "Site web",
            color: AppTheme.redColor,
            data: Constantes.listUserConnecter[0]['siteweb'] ?? "A/N",
          ),
        ],
      ),
    );
  }
}

class UserCustom extends StatelessWidget {
  final Color color;
  final title;
  final IconData icon;
  final data;

  const UserCustom({Key key, this.color, this.title, this.icon, this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${title}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${data}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
