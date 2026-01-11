import '../../../data/models/subscription_model.dart';

abstract class SubscriptionState  {
  const SubscriptionState();
  
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final List<SubscriptionModel> subscriptions;

  const SubscriptionLoaded(this.subscriptions);

  @override
  List<Object?> get props => [subscriptions];
}

class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError(this.message);

  @override
  List<Object?> get props => [message];
}