import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart'; // for basename
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/dio_consumer.dart';
import 'package:lahj_center/core/utils/api/endpoint.dart';
import 'package:lahj_center/feature/items/data/repo/items_repo.dart';

import '../model/advertisminte.dart';

class Itemsrepoimp implements ItemsRepo {
  final DioConsumer dioConsumer;

  Itemsrepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, Advertisement>> addadvertisminte(
      String name,
      String phone,
      int groupid,
      int serviceid,
      int price,
      int currency,
      int governorateid,
      String area,
      String description,
      List<File> images,
      ) async {
    // Convert List<File> to List<MultipartFile>
    List<MultipartFile> imageFiles = [];
    for (var img in images) {
      imageFiles.add(
        await MultipartFile.fromFile(
          img.path,
          filename: basename(img.path),
          // Optionally: contentType: MediaType('image', 'jpeg'), // needs http_parser
        ),
      );
    }

    FormData formData = FormData.fromMap({
      "Name": name,
      "Phone": phone,
      "GroupId": groupid,
      "ServiceId": serviceid,
      "Price": price,
      "CurrencyId": currency,
      "GovernorateId": governorateid,
      "Area": area,
      "Description": description,
      "ImagesToAdd": imageFiles, // List<MultipartFile>
    });

    try {
      final response = await dioConsumer.post(
        EndPoint.addAdvertisement,
        isFromData: true,
        data: formData,
      );

      if (response is String && response == "Advertisement is already registered.") {
        return left(ServerFailure("Advertisement is already registered."));
      }

      if (response is Map<String, dynamic>) {
        final model = Advertisement.fromJson(response);
        return right(model);
      } else {
        return left(ServerFailure("Unexpected response from server"));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}