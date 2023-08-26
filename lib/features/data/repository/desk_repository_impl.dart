import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../../domain/entities/desk.dart';
import '../../domain/repository/desk_repository.dart';

import '../data_sources/desk_remote_data_source.dart';
import '../models/desk_model.dart';

class DeskRepositoryImpl implements DeskRepository {
  final NetworkInfo networkInfo;
  final DeskRemoteDataSource remoteDataSource;

  DeskRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> createDesk(Desk desk) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createDesk(DeskModel.fromEntity(desk));
        return const Right(null);
      } catch (e) {
        return Left(APIFailure());
      }
    }

    // here would be the place for the local data source (e. g. caching)
    return Left(APIFailure());
  }

  @override
  Future<Either<Failure, List<Desk>>> getAllDesks() async {
    if (await networkInfo.isConnected) {
      try {
        final List<Desk> result = await remoteDataSource.getAllDesks();
        return Right(result);
      } catch (e) {
        return Left(APIFailure());
      }
    }

    // here would be the place for the local data source (e. g. caching)
    return Left(APIFailure());
  }

  @override
  Future<Either<Failure, Desk>> getDeskById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final Desk desk = await remoteDataSource.getDeskById(id);
        return Right(desk);
      } catch (e) {
        return Left(APIFailure());
      }
    }

    // here would be the place for the local data source (e. g. caching)
    return Left(APIFailure());
  }

  @override
  Future<Either<Failure, void>> updateDesk(Desk desk) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateDesk(DeskModel.fromEntity(desk));
        return const Right(null);
      } catch (e) {
        return Left(APIFailure());
      }
    }

    // here would be the place for the local data source (e. g. caching)
    return Left(APIFailure());
  }

  @override
  Future<Either<Failure, void>> deleteDesk(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteDesk(id);
        return const Right(null);
      } catch (e) {
        return Left(APIFailure());
      }
    }

    // here would be the place for the local data source (e. g. caching)
    return Left(APIFailure());
  }
}
