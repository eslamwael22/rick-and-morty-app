import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shapes_state.dart';

class ShapesCubit extends Cubit<ShapesState> {
  ShapesCubit() : super(ShapesInitial());
}
