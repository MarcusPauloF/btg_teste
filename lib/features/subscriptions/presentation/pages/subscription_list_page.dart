import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../blocs/subscriptions/subscription_bloc.dart';
import '../blocs/subscriptions/subscription_event.dart';
import '../blocs/subscriptions/subscription_state.dart';


class SubscriptionListPage extends StatelessWidget {
  const SubscriptionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionBloc>().add(FetchSubscriptions());
    });
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final imageSize = screenWidth * 0.18;
    final horizontalPadding = screenWidth * 0.06;
    final titleFontSize = screenWidth * 0.045;
    final descriptionFontSize = screenWidth * 0.035;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Assinaturas'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: AppColors.accentBlue,
                    strokeWidth: 3,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Carregando assinaturas...',
                    style: TextStyle(
                      fontSize: descriptionFontSize,
                      color: AppColors.greyText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SubscriptionError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(horizontalPadding),
                      decoration: BoxDecoration(
                        color: AppColors.errorTransparent10,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.errorTransparent30,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: screenWidth * 0.15,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'Oops! Algo deu errado',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            state.message,
                            style: TextStyle(
                              color: AppColors.greyText,
                              fontSize: descriptionFontSize,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    SizedBox(
                      height: screenHeight * 0.065,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<SubscriptionBloc>()
                              .add(FetchSubscriptions());
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Tentar novamente'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is SubscriptionLoaded) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: horizontalPadding,
              ),
              itemCount: state.subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = state.subscriptions[index];

                return Padding(
                  padding: EdgeInsets.only(bottom: horizontalPadding),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/subscriptions/${subscription.slug}',
                        arguments: subscription,
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.greyBorder,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackTransparent15,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(horizontalPadding * 0.8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: imageSize,
                                height: imageSize,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.primaryMedium,
                                      AppColors.primaryLight,
                                    ],
                                  ),
                                ),
                                child: Image.network(
                                  subscription.image.small,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.accentBlueTransparent50,
                                      ),
                                    );
                                  },
                                  errorBuilder: (_, __, ___) {
                                    return Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: AppColors.whiteTransparent30,
                                        size: imageSize * 0.5,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: horizontalPadding * 0.8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    subscription.name,
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryDark,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.008),
                                  Text(
                                    subscription.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.greyText,
                                      fontSize: descriptionFontSize,
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.success,
                                        size: descriptionFontSize * 1.2,
                                      ),
                                      SizedBox(width: horizontalPadding * 0.4),
                                      Text(
                                        'Ver detalhes',
                                        style: TextStyle(
                                          fontSize: descriptionFontSize * 0.85,
                                          color: AppColors.accentBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AppColors.greyTextTransparent50,
                              size: screenWidth * 0.06,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}