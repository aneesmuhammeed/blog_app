
import 'package:fpdart/fpdart.dart';
import 'package:newflu/core/error/failures.dart';
import 'package:newflu/core/usecase/usecase.dart';
import 'package:newflu/feature/blog/domain/entities/blog.dart';
import 'package:newflu/feature/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
