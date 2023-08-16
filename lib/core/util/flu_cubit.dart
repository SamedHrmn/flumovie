import 'dart:io';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class FluCubit<T> extends HydratedCubit<T> {
  FluCubit(this.cubitState) : super(cubitState);

  final T cubitState;

  static Future<void> init({required Directory dir}) async {
    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: dir);
  }

  static Future<void> clearCache() async {
    await HydratedBloc.storage.clear();
    await HydratedBloc.storage.close();
  }
}
