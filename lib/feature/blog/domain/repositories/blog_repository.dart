import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:newflu/core/error/failures.dart';
import 'package:newflu/feature/blog/domain/entities/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
}
