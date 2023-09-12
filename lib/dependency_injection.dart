import 'package:get_it/get_it.dart';
import 'package:pin_tunnel_application_production/features/feature/data/repository/pin_tunnel_repository.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/repository/i_pin_tunnel_repository.dart';

import 'features/feature/data/data_sources/supabase_service.dart';
import 'features/feature/domain/usecases/sensor_logic.dart';
import 'features/feature/domain/usecases/subscribe_channel_logic.dart';
import 'features/feature/presentation/bloc/PinTunnelBloc.dart';

final sl = GetIt.instance;

Future<void> init() async{
  sl.registerFactory(() => PinTunnelBloc(
    subscribeChannelLogic: sl(),
    sensorLogic: sl(),
  ));


  sl.registerLazySingleton(()=>SubscribeChannelLogic(sl()));

  sl.registerLazySingleton(()=>SensorLogic(sl()));

  //repositories
  sl.registerLazySingleton<IPinTunnelRepository>(
    ()=>PinTunnelRepository()
  );

  sl.registerLazySingleton(()=>SupabaseManager(supabaseUrl: sl(),token: sl()));
}