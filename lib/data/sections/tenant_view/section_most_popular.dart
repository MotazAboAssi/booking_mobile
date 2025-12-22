// import 'package:booking/data/models/tenant_view/appartement_card.dart';
// import 'package:booking/helper/methods/rem.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SectionMostPopular extends StatelessWidget {
//   const SectionMostPopular({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: BlocProvider(
//         create: (BuildContext context) =>  ,
//         child: Column(
//           spacing: 5,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 2.0),
//               child: Text(
//                 "Most Popular",
//                 style: TextStyle(fontSize: rem(2), fontWeight: FontWeight.bold),
//               ),
//             ),
//             AspectRatio(
//               aspectRatio: 7 / 6,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return AspectRatio(
//                     aspectRatio: 1,
//                     child: AppartementCard(isFavorite: false),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:booking/data/models/tenant_view/appartement_card.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class SectionMostPopular extends StatelessWidget {
  const SectionMostPopular({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(
              "Most Popular",
              style: TextStyle(fontSize: rem(2), fontWeight: FontWeight.bold),
            ),
          ),
          AspectRatio(
            aspectRatio: 7 / 6,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: AppartementCard(isFavorite: false),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
