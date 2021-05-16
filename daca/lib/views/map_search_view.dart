import 'package:daca/public/colors.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/viewmodels/map_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MapSearchView extends StatelessWidget {
  // final viewModel;
  static String tag = 'mapSearchView';

  // MapSearchView(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return
        //  ChangeNotifierProvider<MapSearchViewModel>(
        // create: (context) => MapSearchViewModel(),
        // child: Scaffold(
        Scaffold(
      appBar: AppBar(
        title: Text('Where to?'),
        backgroundColor: DaCaColors.primaryColor,
      ),
      body: CustomSearchbar(),
      // ),
    );
  }
}

class CustomSearchbar extends StatelessWidget {
  final controller = FloatingSearchBarController();

  void onPlaceTap() {
    this.controller.close();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapSearchViewModel>(context);

    // Callback called after build is finished
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => {this.controller.open()});

    return FloatingSearchBar(
      hint: DaCaStrings.searchHint,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      maxWidth: 600,
      debounceDelay: Duration(milliseconds: 500),
      controller: this.controller,

      // Call your model, bloc, controller here.
      onQueryChanged: (query) {
        viewModel.onSearchTextChange(query);
      },

      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      builder: (context, transition) {
        return SearchResults(onPlaceTapCallback: this.onPlaceTap);
      },
    );
  }
}

class SearchResults extends StatelessWidget {
  final Function onPlaceTapCallback;

  SearchResults({@required this.onPlaceTapCallback});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapSearchViewModel>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Colors.white,
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: viewModel.searchPlaceList.map((place) {
              return Column(
                children: [
                  ListTile(
                      leading: Container(
                        height: 48,
                        width: 48,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Image.network(
                            place.icon,
                            color: DaCaColors.primaryColor,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                      title: Text(
                        place.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(place.formattedAddress),
                      onTap: () => {
                            this.onPlaceTapCallback(),
                            viewModel.setSelectedPlace(place),
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Text(viewModel.selectedPlace.name),
                                    content: Form(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            initialValue:
                                                viewModel.travelReview.title,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              labelText: 'Title',
                                            ),
                                            onChanged: (text) =>
                                                viewModel.onTitleChange(text),
                                          ),
                                          Divider(color: Colors.transparent),
                                          ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0.0),
                                            title: Text('Rating'),
                                            subtitle: RatingBar.builder(
                                              glow: false,
                                              initialRating:
                                                  viewModel.travelReview.rating,
                                              minRating: 0.5,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: DaCaColors.primaryColor,
                                              ),
                                              onRatingUpdate: (rating) {
                                                viewModel
                                                    .onRatingChange(rating);
                                              },
                                            ),
                                          ),
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              labelText: 'Review',
                                            ),
                                            onChanged: (text) =>
                                                viewModel.onReviewChange(text),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      RaisedButton(
                                          child: Text("Submit"),
                                          onPressed: () async {
                                            await viewModel
                                                .onSubmitReviewPress();
                                            Navigator.pop(context);
                                          })
                                    ],
                                  );
                                }),
                          }),
                  Divider(
                    thickness: 1.0,
                    height: 10.0,
                    indent: 12.0,
                    endIndent: 12.0,
                    color: DaCaColors.dacaGrey,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}