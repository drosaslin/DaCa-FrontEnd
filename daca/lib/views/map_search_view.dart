import 'package:daca/public/colors.dart';
import 'package:daca/viewmodels/map_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class MapSearchView extends StatelessWidget {
  static String tag = 'mapSearchView';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapSearchViewModel>(
      create: (context) => MapSearchViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Where to?'),
          backgroundColor: DaCaColors.primaryColor,
        ),
        body: CustomSearchbar(),
      ),
    );
  }
}

class CustomSearchbar extends StatelessWidget {
  final isPortrait = true;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapSearchViewModel>(context);

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: Duration(milliseconds: 500),
      onQueryChanged: (query) {
        viewModel.onSearchTextChange(query);
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
