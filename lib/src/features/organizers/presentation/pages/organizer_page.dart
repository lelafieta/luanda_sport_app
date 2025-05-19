import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/config/routes/app_routes.dart';
import 'package:luanda_sport_app/src/core/resources/app_icons.dart';
import 'package:get/get.dart';

import '../../../../config/themes/app_colors.dart';

class OrganizerPage extends StatefulWidget {
  const OrganizerPage({super.key});

  @override
  State<OrganizerPage> createState() => _OrganizerPageState();
}

class _OrganizerPageState extends State<OrganizerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SafeArea(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          //     child: Row(
          //       children: [
          //         Container(
          //           width: 50,
          //           height: 50,
          //           decoration: BoxDecoration(
          //             color: AppColors.primary.withOpacity(0.1),
          //             shape: BoxShape.circle,
          //           ),
          //           child: IconButton(
          //             padding: const EdgeInsets.all(8.0),
          //             icon: const Icon(
          //               Icons.arrow_back,
          //               color: AppColors.black,
          //             ),
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //         ),
          //         Expanded(
          //           child: Center(
          //             child: Text(
          //               "Organizadores",
          //               overflow: TextOverflow.ellipsis,
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .titleMedium!
          //                   .copyWith(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.black),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           width: 50,
          //           height: 50,
          //           decoration: const BoxDecoration(
          //             color: AppColors.primary.withOpacity(0.1),
          //             shape: BoxShape.circle,
          //           ),
          //           child: IconButton(
          //             padding: const EdgeInsets.all(8.0),
          //             icon: const Icon(
          //               Icons.more_vert,
          //               color: AppColors.black,
          //             ),
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    // color: AppColors.primary,
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white,
                                hintText: 'Pesquisar organizador',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 16.0,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                    AppIcons.search,
                                    width: 20,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: 10, // Number of elements (2 to 10)
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.organizerDetails);
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12.0),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Image.network(
                                              'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-6/468946321_1143394810468991_6731165110528390324_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wSrOeJxvDDEQ7kNvwEbvT6L&_nc_oc=AdlTqHYlCPFGfrAGQlDwBDoWGWHzOtYBQvPLz5DFEahZRV2c0WoBBuSIrcQrBKYO_91fpJuk6Y9c1v6oU_Uldije&_nc_zt=23&_nc_ht=scontent.flad5-1.fna&_nc_gid=bu1cwd0CKmhmqZJFsKvxIg&oh=00_AfHS3wRkCA00310Cb6BF1t2f-b46KjsWZzhIrcgxTejGig&oe=68048141',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              color: AppColors.primary
                                                  .withOpacity(.2),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Organizer ${index + 1}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: AppColors.primary,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppIcons.marker,
                                                width: 14,
                                              ),
                                              const SizedBox(width: 4.0),
                                              const Text(
                                                'Luanda, Benfica',
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'Desde: 2023-01-01',
                                            style:
                                                const TextStyle(fontSize: 12.0),
                                          ),
                                          const SizedBox(height: 4.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 15,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.09),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: '0',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' TORNEIOS',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
