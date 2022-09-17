import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/domain/repositories/authorization_repository.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_cubit.dart';
import 'package:maybe_movie/src/utils/logger.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._authRepository,
    this._errorWrapperCubit,
  ) : super(const HomeState());

  final AuthRepository _authRepository;

  final ErrorWrapperCubit _errorWrapperCubit;

  final logger = getLogger('HomeCubit');

  Future<void> logOut() async {
    try {
      _authRepository.logOut();
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
  }
}
