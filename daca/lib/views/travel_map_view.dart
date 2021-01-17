import 'dart:async';

import 'package:daca/colors.dart';
import 'package:daca/public/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daca/viewmodels/travel_map_view_model.dart';

class TravelMapView extends StatefulWidget {
  @override
  _TravelMapViewState createState() => _TravelMapViewState();
}

class _TravelMapViewState extends State<TravelMapView>
    with AutomaticKeepAliveClientMixin<TravelMapView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ChangeNotifierProvider<TravelMapViewModel>(
        create: (context) => TravelMapViewModel(),
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
    final viewModel = Provider.of<TravelMapViewModel>(context);

    return Consumer<TravelMapViewModel>(
      builder: (BuildContext context, value, Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          spacing: 7.0,
          children: [
            FilterChip(
              // avatar: CircleAvatar(child: Text('D')),
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

  void _onMapCreated(GoogleMapController controller) async {
    print('map created');
    mapController = controller;
    // await this.widget.viewModel.getCurrentPosition(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
        // zoom: this.widget.viewModel.zoomAmount,
      ),
      // markers: this.markers,
    );
  }
}
