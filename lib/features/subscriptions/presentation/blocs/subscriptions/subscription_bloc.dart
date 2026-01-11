import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/subscription_repository.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc
    extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository repository;

  SubscriptionBloc(this.repository) : super(SubscriptionInitial()) {
    on<FetchSubscriptions>(_onFetchSubscriptions);
  }

  Future<void> _onFetchSubscriptions(
    FetchSubscriptions event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());

    try {
      final subscriptions = await repository.getSubscriptions();
      emit(SubscriptionLoaded(subscriptions));
    } catch (e) {
      emit(const SubscriptionError('Erro ao carregar assinaturas'));
    }
  }
}