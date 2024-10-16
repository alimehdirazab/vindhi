import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vindhi_app/core/ui.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:vindhi_app/data/models/Banner/banner_model.dart';
import 'package:vindhi_app/logic/cubit/banner%20cubit/banner_cubit.dart';
import 'package:vindhi_app/logic/cubit/banner%20cubit/banner_state.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/business_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/car_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/education_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/home_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/professional_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/loans/property_loan_form.dart';
import 'package:vindhi_app/presentation/pages/client_app/widgets/loan_card.dart';
import 'package:vindhi_app/presentation/pages/others/notification_screen.dart';
import 'package:vindhi_app/presentation/widgets/gap_widget.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreen();
}

class _ClientHomeScreen extends State<ClientHomeScreen> {
  late BannerCubit _bannerCubit;
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _bannerCubit = BlocProvider.of<BannerCubit>(context);
    _bannerCubit.fetchBanner();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/app_logo.png', height: 30),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, NotificationScreen.routeName);
                    },
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.grey,
                    )),
              ],
            ),
            BlocBuilder<BannerCubit, BannerState>(
              builder: (context, state) {
                if (state is BannerLoadingState) {
                  // Show shimmer while loading banner
                  return _buildShimmerBanner();
                } else if (state is BannerSuccessState) {
                  return _buildBannerUI(state.response.banners);
                } else if (state is BannerFailureState) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Most Popular',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCircleButton(
                    Icons.calculate_outlined, 'EMI Calculator', () {}),
                _buildCircleButton(
                    Icons.quickreply_outlined, 'Get A Quiry', () {}),
                _buildCircleButton(Icons.score, 'Credit Score', () {}),
              ],
            ),
            const SizedBox(height: 25),
            Card(
              elevation: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                // Applying the gradient to the Scaffold background
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(
                          186, 125, 195, 252), // Starting color (Green)
                      Colors.white, // Ending color (Orange)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enable Your Dreams With',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LoanCard(
                          label: 'Home\nLoan',
                          imagePath: 'assets/vindhi_icons/instant-loan.png',
                          onTap: () => Navigator.pushNamed(
                            context,
                            HomeLoanForm.routeName,
                          ),
                        ),
                        LoanCard(
                          label: 'Education\nLoan',
                          imagePath: 'assets/vindhi_icons/personal-loan.png',
                          onTap: () => Navigator.pushNamed(
                            context,
                            EducationLoanForm.routeName,
                          ),
                        ),
                        LoanCard(
                          label: 'Business\nLoan',
                          imagePath: 'assets/vindhi_icons/business-loan.png',
                          onTap: () => Navigator.pushNamed(
                            context,
                            BusinessLoanForm.routeName,
                          ),
                        ),
                      ],
                    ),
                    const GapWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LoanCard(
                          label: 'Professional\nLoan',
                          imagePath:
                              'assets/vindhi_icons/professional-loan.png',
                          onTap: () => Navigator.pushNamed(
                            context,
                            ProfessionalLoanForm.routeName,
                          ),
                        ),
                        LoanCard(
                          label: 'Pre-Owned\nLoan',
                          imagePath:
                              'assets/vindhi_icons/pre-owned-car-loan.png',
                          onTap: () => Navigator.pushNamed(
                              context, CarLoanForm.routeName),
                        ),
                        LoanCard(
                          label: 'Loan\nAgainst\nProperty',
                          imagePath:
                              'assets/vindhi_icons/loan-against-property.png',
                          onTap: () => Navigator.pushNamed(
                              context, PropertyLoanForm.routeName),
                        ),
                        // const LoanCard(
                        //   label: 'Medical\nequipment\nLoan',
                        //   imagePath:
                        //       'assets/vindhi_icons/medical-equipment-loan.png',
                        // ),
                        // const LoanCard(
                        //   label: 'Machinery\nLoan',
                        //   imagePath: 'assets/vindhi_icons/machinery-loan.png',
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBannerUI(List<BannerItem> banners) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 155,
            viewportFraction: 0.8,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
          items: banners.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imagePath.banners),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const GapWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: banners.asMap().entries.map((entry) {
            return GestureDetector(
              child: Container(
                width: _currentBannerIndex == entry.key ? 25 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  shape: BoxShape.rectangle,
                  color: _currentBannerIndex == entry.key
                      ? AppColors.primaryColor
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Build shimmer effect for the banner while loading
  Widget _buildShimmerBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 155,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 155,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCircleButton(
      IconData icon, String label, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style:
                TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
