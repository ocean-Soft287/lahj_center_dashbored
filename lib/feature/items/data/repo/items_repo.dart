import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';

import '../model/advertisminte.dart';

abstract class ItemsRepo{
  Future<Either<Failure,Advertisement>>addadvertisminte(
      String name,
      String phone,
      int groupid,
      int serviceid,
      int price,
      int currency,
      int governorateid,
      String area,
      String description,
     List<File>x,
      );

// Future<Either<Failure,>>

}