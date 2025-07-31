import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';

import '../model/advertisminte.dart';

abstract class ItemsRepo{
  Future<Either<Failure,Item>>addadvertisminte(
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

Future<Either<Failure,List<Item>>>getalladvertisminte();

Future<Either<Failure,String>>approval(int x);
  Future<Either<Failure, String>> deletemyadd(int id,String reason);

}