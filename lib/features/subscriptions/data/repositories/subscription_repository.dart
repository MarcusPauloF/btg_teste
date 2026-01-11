import '../datasources/subscription_remote_datasource.dart';
import '../models/subscription_model.dart';

class SubscriptionRepository {
  final SubscriptionRemoteDatasource remoteDatasource;

  SubscriptionRepository(this.remoteDatasource);

  Future<List<SubscriptionModel>> getSubscriptions() async {
    try {
      return await remoteDatasource.fetchSubscriptions();
    } catch (e) {
      rethrow;
    }
  }
}