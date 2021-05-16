import 'package:daca/public/colors.dart';
import 'package:daca/public/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
            OptionChipsWidget(),
          ],
        ),
      ),
    );
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

    viewModel.setOnCurrentPositionChange(this.onCurrentPositionChange);

    return GoogleMap(
      onMapCreated: (GoogleMapController controller) => {
        this.mapController = controller,
        viewModel.getCurrentPosition(),
        viewModel.getReviews(),
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
      ),
      markers: viewModel.markers,
      myLocationEnabled: this.myLocationEnabled,
      myLocationButtonEnabled: this.myLocationbuttonEnabled,
      zoomControlsEnabled: this.zoomControlsEnabled,
    );
  }
}
