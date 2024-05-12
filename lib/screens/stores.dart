import 'package:flutter/material.dart';
import 'package:restaurants_sys/models/stores.dart';
import 'package:restaurants_sys/utilities/services/all_store.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final AllStores allStores = AllStores();
  String _selectedStoreType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C5CB3),
        title: Text(
          'Stores',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Store>>(
        future: allStores.getAllStores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Store> stores = snapshot.data ?? [];
            List<Store> filteredStores =
                _selectedStoreType.toLowerCase() == 'all'
                    ? stores
                    : stores
                        .where((store) =>
                            store.type.toLowerCase() ==
                            _selectedStoreType.toLowerCase())
                        .toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: _selectedStoreType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedStoreType = newValue!;
                      });
                    },
                    items: <String>['All', 'Restaurant', 'Cafe']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredStores.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            onTap: () {
                              // Handle tap action if needed
                            },
                            title: Text(
                              filteredStores[index].name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:restaurants_sys/models/stores.dart';
// import 'package:restaurants_sys/utilities/services/all_store.dart';

// class StoreScreen extends StatefulWidget {
//   @override
//   _StoreScreenState createState() => _StoreScreenState();
// }

// class _StoreScreenState extends State<StoreScreen> {
//   final AllStores allStores = AllStores();
//   String _selectedStoreType = 'All';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF8C5CB3),
//         title: Text(
//           'Stores',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: FutureBuilder<List<Store>>(
//         future: allStores.getAllStores(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             List<Store> stores = snapshot.data ?? [];
//             List<Store> filteredStores =
//                 _selectedStoreType.toLowerCase() == 'all'
//                     ? stores
//                     : stores
//                         .where((store) =>
//                             store.type.toLowerCase() ==
//                             _selectedStoreType.toLowerCase())
//                         .toList();
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DropdownButtonFormField<String>(
//                     value: _selectedStoreType,
//                     onChanged: (newValue) {
//                       setState(() {
//                         _selectedStoreType = newValue!;
//                       });
//                     },
//                     items: <String>['All', 'Restaurant', 'Cafe']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredStores.length,
//                     itemBuilder: (context, index) {
//                       String iconPath = '';
//                       switch (filteredStores[index].type.toLowerCase()) {
//                         case 'restaurant':
//                           iconPath = "assets/images/rest.png";
//                           break;
//                         case 'cafe':
//                           iconPath = "assets/images/cafe.png";
//                           break;
//                         default:
//                           iconPath = "assets/images/default.png";
//                       }
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: ListTile(
//                             contentPadding: EdgeInsets.zero,
//                             onTap: () {
//                               // Handle tap action if needed
//                             },
//                             leading: iconPath.isNotEmpty
//                                 ? Image.asset(
//                                     iconPath,
//                                     width: 100,
//                                     height: 100,
//                                   )
//                                 : SizedBox(),
//                             title: Text(
//                               filteredStores[index].name,
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
