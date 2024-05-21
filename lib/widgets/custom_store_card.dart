import 'package:flutter/material.dart';
import 'package:restaurants_sys/models/product_model.dart';
import 'package:restaurants_sys/models/store_model.dart';
import 'package:restaurants_sys/widgets/store_directions_map.dart';

class CustomStoreCard extends StatelessWidget {
  const CustomStoreCard(
      {super.key, required this.store, required this.product});

  final Store store;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoreDirectionsMap(store: store),
          ),
        );
      },
      child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 50,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            width: 200,
            height: 250,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(
                      store.type=='RESTAURANT'?'assets/images/rest.png':'assets/images/cafe.png',
                      height: 80,
                      width: 80,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            store.name,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          Spacer(flex: 1,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text
                                ('${_getProductPriceForStore()} L.E'),
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  int _getProductPriceForStore() {
    int productPrice = 0;
    for (var s in product.stores!) {
      if (store.id == s.storeId) {
        productPrice = s.productPrice;
      }
    }
    return productPrice;
  }
}
