// import 'package:flutter/widgets.dart';

// class DetailSummaryPage extends StatelessWidget {
//   const DetailSummaryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.transparent,
//             expandedHeight: 500.0,
//             flexibleSpace: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(40.0),
//                 bottomRight: Radius.circular(40.0),
//               ),
//               child: Image.network(
//                 height: 550,
//                 place.imageUrl,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: smallPadding,
//               child: Column(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         textAlign: TextAlign.center,
//                         place.name,
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleMedium
//                             ?.copyWith(fontSize: 24.0),
//                       ),
//                       AddressWidget(
//                           latitude: place.latitude, longitude: place.longitude),
//                       smallSizedBoxHeight,
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Text('Overview',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineMedium
//                               ?.copyWith(fontSize: 15)),
//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Text(
//                         place.description,
//                         style: Theme.of(context).textTheme.headlineSmall,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   }

