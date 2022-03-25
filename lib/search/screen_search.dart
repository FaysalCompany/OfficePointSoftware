import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2/bloc/identify_bloc.dart';
import 'package:v2/utils/app_theme.dart';

class SearchOperation extends SearchDelegate<String> {
  SearchOperation();
  var bloc;
  @override
  String get searchFieldLabel => "Rercherche";
  @override
  get searchFieldStyle => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppTheme.redColor,
      );
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        // semanticLabel: "Entre votre nom",
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc = BlocProvider.of<IdentifyBloc>(context);
    final Iterable<dynamic> suggestions = bloc.replay.where((word) {
      return word['nom']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          word['dateNaiss']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          word['mail'].toString().toLowerCase().contains(query.toLowerCase());
    });
    final searched = suggestions.toList();

    return searched.length > 0
        ? ListView.builder(
            itemCount: searched.length,
            itemBuilder: (context, index) {
              var data = searched[index];
              return CardItem(
                data: data,
                searchDelegate: this,
              );
            },
          )
        : Center(
            child: Text(
              "Aucun résultat trouvé",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildMatchingSuggestions(context);
  }

  Widget buildMatchingSuggestions(BuildContext context) {
    bloc = BlocProvider.of<IdentifyBloc>(context);
    if (query.isEmpty) {
      return ListView.builder(
        itemCount: bloc.replay.length,
        itemBuilder: (context, index) {
          var data = bloc.replay[index];
          return CardItem(
            data: data,
            searchDelegate: this,
          );
        },
      );
    }

    final Iterable<dynamic> suggestions = this.query.isEmpty
        ? []
        : bloc.playData.where((word) =>
            word['nom']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            word['dateNaiss']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            word['mail']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()));
    final searched = suggestions.toList();

    if (searched.length == 0) {
      return Center(
        child: Text(
          "Aucun résultat trouvé",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: searched.length,
      itemBuilder: (context, index) {
        var data = searched[index];
        return CardItem(
          data: data,
          searchDelegate: this,
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isEmpty
        ? []
        : <Widget>[
            IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          ];
  }
}

class CardItem extends StatelessWidget {
  final data;
  final SearchDelegate<String> searchDelegate;

  const CardItem({Key key, this.data, this.searchDelegate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rlt = {
      "${data['id']}%^",
      "${data['nom']}**",
      "${data['sexe']}++",
      "${data['dateNaiss']}##",
      "${data['tel']}&&",
      "${data['adresse']}^^",
      "${data['mail']}%%",
      "${data['fonction']}!!",
      "${data['type']}=="
    };
    return GestureDetector(
      onTap: () {
        searchDelegate.close(context, rlt.toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Material(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['nom'].toString().toUpperCase() ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                        data['type'].toString().toUpperCase() ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppTheme.blueColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Text(
                        data['id'].toString().toUpperCase() ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                // Text(
                //   data['dateNaiss'].toString().toUpperCase() ?? "",
                //   style: TextStyle(
                //     color: Colors.black,
                //     // fontWeight: FontWeight.w500,
                //     fontSize: 12,
                //   ),
                // ),
                Divider(
                  color: AppTheme.blueColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
