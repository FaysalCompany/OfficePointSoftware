import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:v2/app/source.dart';
import 'package:v2/utils/app_theme.dart';

class ViewImage extends StatefulWidget {
  final data;

  const ViewImage({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ViewImage();
  }
}

class _ViewImage extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.blueColor,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        actions: [],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.data['nom'].toString().toUpperCase()}",
              style: TextStyle(
                color: AppTheme.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              child: CachedNetworkImage(
                useOldImageOnUrlChange: true,
                imageUrl:
                    "${DataSource.imgUrl}${widget.data['image'] == '1' ? widget.data['codeAgent'] : 'default'}.png",
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                placeholder: (context, url) => SpinKitCircle(
                  duration: Duration(seconds: 3),
                  color: AppTheme.redColor,
                  size: 25,
                ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.colorBurn,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.redColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.redColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Text(
                                "${widget.data['codeAgent'] ?? ""}    ${widget.data['sortie'] ?? ""}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.data['justification'] ?? ""}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
