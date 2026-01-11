import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/subscription_model.dart';
import '../blocs/subscriptions/subscription_bloc.dart';
import '../blocs/subscriptions/subscription_state.dart';

class SubscriptionDetailPage extends StatelessWidget {
  final SubscriptionModel? subscription;
  final String? slug;

  const SubscriptionDetailPage({
    super.key,
    this.subscription,
    this.slug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        SubscriptionModel? resolvedSubscription = subscription;

        if (resolvedSubscription == null &&
            slug != null &&
            state is SubscriptionLoaded) {
          resolvedSubscription = state.subscriptions
              .firstWhere((item) => item.slug == slug);
        }

        if (resolvedSubscription == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.accentBlue,
              ),
            ),
          );
        }

        final item = resolvedSubscription;
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final padding = screenWidth * 0.06;
        final titleFontSize = screenWidth * 0.065;
        final subtitleFontSize = screenWidth * 0.04;
        final bodyFontSize = screenWidth * 0.035;

        return Scaffold(
          appBar: AppBar(
            title: Text(item.name),
            elevation: 0,
          ),
          backgroundColor: AppColors.scaffoldBackground,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primaryDark,
                              AppColors.primaryMedium,
                              AppColors.primaryLight,
                            ],
                          ),
                        ),
                        child: Image.network(
                          item.image.large,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primaryDark,
                                    AppColors.primaryMedium,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: screenWidth * 0.2,
                                  color: Colors.white.withValues(alpha: 0.3),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.primaryDark.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          color: AppColors.greyText,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.greyBorder,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(padding * 0.8),
                              child: Text(
                                'Autores',
                                style: TextStyle(
                                  fontSize: subtitleFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accentBlue,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: AppColors.greyBorder,
                            ),
                            ...item.authors.asMap().entries.map((entry) {
                              final isLast =
                                  entry.key == item.authors.length - 1;
                              return Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: padding * 0.8,
                                      vertical: screenHeight * 0.01,
                                    ),
                                    leading: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.accentBlue
                                            .withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.person_outline,
                                        color: AppColors.accentBlue,
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      entry.value,
                                      style: TextStyle(
                                        fontSize: bodyFontSize,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.accentBlue,
                                      ),
                                    ),
                                  ),
                                  if (!isLast)
                                    Divider(
                                      height: 1,
                                      indent: padding * 2.5,
                                      endIndent: padding * 0.8,
                                      color: AppColors.greyBorder,
                                    ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.greyBorder,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(padding * 0.8),
                              child: Text(
                                'Features',
                                style: TextStyle(
                                  fontSize: subtitleFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accentBlue,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: AppColors.greyBorder,
                            ),
                            ...item.features.asMap().entries.map((entry) {
                              final isLast =
                                  entry.key == item.features.length - 1;
                              return Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: padding * 0.8,
                                      vertical: screenHeight * 0.01,
                                    ),
                                    leading: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: AppColors.success
                                            .withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check_circle_outline,
                                        color: AppColors.success,
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      entry.value,
                                      style: TextStyle(
                                        fontSize: bodyFontSize,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.accentBlue,
                                      ),
                                    ),
                                  ),
                                  if (!isLast)
                                    Divider(
                                      height: 1,
                                      indent: padding * 2.5,
                                      endIndent: padding * 0.8,
                                      color: AppColors.greyBorder,
                                    ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
