import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vindhi_app/core/ui.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:vindhi_app/data/models/Banner/banner_model.dart';
import 'package:vindhi_app/logic/cubit/banner%20cubit/banner_cubit.dart';
import 'package:vindhi_app/logic/cubit/banner%20cubit/banner_state.dart';
import 'package:vindhi_app/presentation/pages/others/lead_form_screen.dart';
import 'package:vindhi_app/presentation/widgets/gap_widget.dart';
import 'package:vindhi_app/presentation/widgets/option_card.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Anuj Rana',
                          style: TextStyles.body1
                              .copyWith(color: Colors.white, fontSize: 16)),
                      Text('User ID: 123456',
                          style: TextStyles.body1
                              .copyWith(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Available Credit: 1000',
                      style: TextStyles.body1
                          .copyWith(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
            Card(
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OptionCard(
                          text: 'Attendance\n',
                          icon: Icons.calendar_today_outlined,
                          onPressed: () {},
                        ),
                        OptionCard(
                          text: 'Lead Customer\n        Form',
                          icon: Icons.assignment_turned_in_outlined,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, LeadFormScreen.routeName);
                          },
                        ),
                        OptionCard(
                          text: 'Approve/\nDisapprove',
                          icon: Icons.check_circle_outline,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OptionCard(
                          text: 'Salary Slip',
                          icon: Icons.money_off_outlined,
                          onPressed: () {},
                        ),
                        OptionCard(
                          text: 'Help & Support',
                          icon: Icons.help_outline,
                          onPressed: () {},
                        ),
                        OptionCard(
                          text: 'Rating',
                          icon: Icons.star_border_outlined,
                          onPressed: () {},
                        ),
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
            height: 130,
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
}
