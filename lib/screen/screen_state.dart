import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v2/bloc/presence_bloc.dart';
import 'package:v2/utils/start_activity.dart';
import 'package:v2/utils/widget.dart';

class ScreenState extends StatefulWidget {
  final data;
  final initBloc;

  const ScreenState({Key key, this.data, this.initBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<ScreenState> {
  @override
  void initState() {
    super.initState();
    widget.initBloc.add(PresencesendData(data: widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Material(
        color: Colors.transparent,
        child:
            BlocBuilder<PresenceBloc, PresenceState>(builder: (context, state) {
          if (state is PresenceInitial) {
            return Center(
              child: Load(),
            );
          }
          if (state is PresencePregress) {
            return Center(
              child: Load(),
            );
          }
          if (state is PresenceIsEmpty) {
            return Center(
              child: BuildMessage(
                sizeImage: 150.0,
                sizeText: 18.0,
              ),
            );
          }
          if (state is PresenceConnected) {
            return Center(
              child: BuildMessageConnected(
                sizeImage: 150.0,
                sizeText: 18.0,
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
            );
          } else {
            // return await Navigator.of(context).pushNamedAndRemoveUntil(
            //     '/presence', (Route<dynamic> route) => false);
            // startActivityWithoutBackPop(context, '/presence');
            return Center(
              child: BuildMessageSucces(
                sizeImage: 150.0,
                sizeText: 18.0,
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
            );
          }
        }
                //, child: BlocBuilder<PresenceBloc, PresenceState>(
                //   builder: (context, state) {
                //     return Container(
                //       width: double.infinity,
                //       color: Colors.white,
                //       height: MediaQuery.of(context).size.height * .5,
                //     );
                //   },
                // )),
                ),
      ),
    );
  }
}
