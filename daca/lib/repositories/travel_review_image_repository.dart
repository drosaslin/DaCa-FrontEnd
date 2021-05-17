import 'dart:convert';
import 'package:daca/public/exceptions.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/models/travel_review.dart';
import 'package:daca/public/api_endpoints.dart';
import 'package:daca/public/variables.dart';
import 'irepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class TravelReviewImageRepository implements IRepository<TravelReview> {
  @override
  Future<TravelReview> create(TravelReview t) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<TravelReview> delete(TravelReview t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<TravelReview> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<TravelReview>> getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<List<TravelReview>> getListById(String id) {
    // TODO: implement getListById
    throw UnimplementedError();
  }

  @override
  Future<TravelReview> update(TravelReview t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
