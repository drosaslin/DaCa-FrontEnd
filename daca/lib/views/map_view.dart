import 'package:daca/customwidgets/hero_dialog_route.dart';
import 'package:daca/models/travel_review.dart';
import 'package:daca/public/colors.dart';
import 'package:daca/public/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daca/viewmodels/map_view_model.dart';

class MapView extends StatefulWidget {
  final MapViewModel viewModel;

  MapView(this.viewModel);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView>
    with AutomaticKeepAliveClientMixin<MapView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ChangeNotifierProvider<MapViewModel>(
        create: (context) => widget.viewModel,
        child: Stack(
          children: [
            MapWidget(),
            Builder(
              builder: (context) {
                final viewModel = Provider.of<MapViewModel>(context);
                return Positioned(
                  top: viewModel.getInfoWindowTop(),
                  left: viewModel.getInfoWindowLeft(),
                  child: CustomInfoWindow(),
                );
              },
            ),
            OptionChipsWidget(),
          ],
        ),
      ),
    );
  }
}

class CustomInfoWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapViewModel>(context);

    return Visibility(
      visible: viewModel.isInfoWindowVisible(),
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => Center(
                child: ReviewModal(review: viewModel.selectedReview),
              ),
            ),
          ),
        },
        child: Hero(
          tag: (viewModel.selectedReview != null)
              ? viewModel.selectedReview.id
              : '',
          child: Material(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.white,
              child: (viewModel.isInfoWindowVisible())
                  ? Text(viewModel.selectedReview.title)
                  : Text(''),
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewModal extends StatelessWidget {
  final review;

  ReviewModal({this.review});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: review.id,
        child: Material(
          child: Container(
            width: 300,
            height: 500,
            color: Colors.white,
            child: Container(
              child: Text(
                review.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ));
  }
}

class OptionChipsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapViewModel>(context);

    return Consumer<MapViewModel>(
      builder: (BuildContext context, value, Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          spacing: 7.0,
          children: [
            FilterChip(
              label: Text(DaCaStrings.foodChip),
              selectedColor: DaCaColors.primaryColor,
              disabledColor: Colors.white,
              selected: viewModel.foodChipState,
              onSelected: (_) => viewModel.onFoodChipPress(),
            ),
            FilterChip(
              label: Text(DaCaStrings.travelChip),
              selectedColor: DaCaColors.primaryColor,
              selected: viewModel.travelChipState,
              onSelected: (_) => viewModel.onTravelChipPress(),
            ),
            FilterChip(
              label: Text(DaCaStrings.lifeChip),
              selectedColor: DaCaColors.primaryColor,
              selected: viewModel.lifeChipState,
              onSelected: (_) => viewModel.onLifeChipPress(),
            ),
            FilterChip(
              label: Text(DaCaStrings.friendChip),
              selectedColor: DaCaColors.primaryColor,
              selected: viewModel.friendChipState,
              onSelected: (_) => viewModel.onFriendChipPress(),
            ),
            FilterChip(
              label: Text(DaCaStrings.allChip),
              selectedColor: DaCaColors.primaryColor,
              selected: viewModel.allChipState,
              onSelected: (_) => viewModel.onAllChipPress(),
            ),
          ],
        ),
      ),
    );
  }
}

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController mapController;
  final myLocationEnabled = true;
  final myLocationbuttonEnabled = false;
  final zoomControlsEnabled = false;

  void onCurrentPositionChange(Position position) {
    this.mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                position.latitude,
                position.longitude,
              ),
              zoom: 17,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapViewModel>(context, listen: true);

    /**
     ** Setting up the callback functions needed for this view
     */
    viewModel.setOnCurrentPositionChange(this.onCurrentPositionChange);

    return GoogleMap(
      onMapCreated: (GoogleMapController controller) => {
        this.mapController = controller,

        /**
         ** Fetching the user's current position and 
         ** list of reviews after the map is created
         */
        viewModel.onMapCreated(),
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
      ),
      onTap: (_) => viewModel.setSelectedReview(null),
      onCameraMove: (_) async {
        if (viewModel.getSelectedReview() != null) {
          final coordinates = await this.mapController.getScreenCoordinate(
                LatLng(
                  viewModel
                      .getSelectedReview()
                      .getPlace()
                      .geometry
                      .location
                      .lat,
                  viewModel.getSelectedReview().place.geometry.location.lng,
                ),
              );

          await viewModel.onMapPositionChange(
            coordinates.x.toDouble(),
            coordinates.y.toDouble(),
            MediaQuery.of(context).devicePixelRatio,
          );
        }
      },
      markers: Set<Marker>.of(
        viewModel.travelReviewList.map(
          (review) => Marker(
            consumeTapEvents: true,
            markerId: MarkerId(review.place.placeId),
            position: LatLng(
              review.place.geometry.location.lat,
              review.place.geometry.location.lng,
            ),
            onTap: () async {
              viewModel.setSelectedReview(review);

              final coordinates = await this.mapController.getScreenCoordinate(
                    LatLng(
                      review.place.geometry.location.lat,
                      review.place.geometry.location.lng,
                    ),
                  );

              viewModel.onMapPositionChange(
                coordinates.x.toDouble(),
                coordinates.y.toDouble(),
                MediaQuery.of(context).devicePixelRatio,
              );
            },
          ),
        ),
      ),
      myLocationEnabled: this.myLocationEnabled,
      myLocationButtonEnabled: this.myLocationbuttonEnabled,
      zoomControlsEnabled: this.zoomControlsEnabled,
    );
  }
}

// class ReviewInfoDialog extends StatelessWidget {
  // final TravelReview travelReview;

  // ReviewInfoDialog({this.travelReview});

  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     scrollable: true,
  //     title: Text(this.travelReview.title),
  //     content: Form(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(this.travelReview.review),
  //           Text(this.travelReview.rating.toString()),
  //         ],
  //       ),
  //     ),
  //   );
  // }
// }
