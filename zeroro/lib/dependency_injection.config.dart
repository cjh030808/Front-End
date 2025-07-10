// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:zeroro/data/data_source/community/community.api.dart' as _i1010;
import 'package:zeroro/data/data_source/data_source_module.dart' as _i321;
import 'package:zeroro/data/repository_impl/community.repository_impl.dart'
    as _i578;
import 'package:zeroro/domain/repository/community.repository.dart' as _i405;
import 'package:zeroro/presentation/screens/main/pages/community/bloc/community_bloc.dart'
    as _i805;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dataSourceModule = _$DataSourceModule();
    gh.singleton<_i1010.CommunityApi>(() => dataSourceModule.communityApi);
    gh.singleton<_i405.CommunityRepository>(
      () => _i578.CommunityRepositoryImpl(gh<_i1010.CommunityApi>()),
    );
    gh.factory<_i805.CommunityBloc>(
      () => _i805.CommunityBloc(gh<_i405.CommunityRepository>()),
    );
    return this;
  }
}

class _$DataSourceModule extends _i321.DataSourceModule {}
