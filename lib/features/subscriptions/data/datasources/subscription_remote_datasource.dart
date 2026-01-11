import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/subscription_model.dart';


class SubscriptionRemoteDatasource {
  static const String _baseUrl =
      'https://empiricus-app.empiricus.com.br/mock/list.json';

  Future<List<SubscriptionModel>> fetchSubscriptions() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar assinaturas');
    }

    final Map<String, dynamic> jsonBody =
        jsonDecode(response.body) as Map<String, dynamic>;

    final List<dynamic> groups = jsonBody['groups'] as List<dynamic>;

    final List<SubscriptionModel> subscriptions = groups
        .map((group) =>
            _mapGroupToSubscription(group as Map<String, dynamic>))
        .toList();

    return subscriptions;
  }

  SubscriptionModel _mapGroupToSubscription(Map<String, dynamic> group) {
    return SubscriptionModel(
      slug: group['identifier']['slug'] as String,
      name: group['name'] as String,
      description: group['description'] as String,
      image: SubscriptionImage(
        small: group['imageSmall'] as String,
        large: group['imageLarge'] as String,
      ),
      authors: (group['authors'] as List<dynamic>)
          .map((author) => author['name'] as String)
          .toList(),
      features: (group['features'] as List<dynamic>)
          .map((feature) => feature['title'] as String)
          .toList(), shortDescription: '',
    );
  }
}