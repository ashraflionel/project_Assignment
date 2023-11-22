import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/product_model.dart';
import 'package:flutter_application_1/Services/product_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
    bool itsAdded = false;
  String _selectedLocation="smartphones";
  List<String> _locations = [
    "smartphones",
    "laptops",
    "fragrances",
    "skincare",
    "groceries",
    "home-decoration",
    "furniture",
    "tops",
    "womens-dresses",
    "womens-shoes",
    "mens-shirts",
    "mens-shoes",
    "mens-watches",
    "womens-watches",
    "womens-bags",
    "womens-jewellery",
    "sunglasses",
    "automotive",
    "motorcycle",
    "lighting"
];

ProductModel? _productModel;

@override
  void initState() {
    if (context.read<ProductListAPIProvider>().productResponseModel == null) {
      context.read<ProductListAPIProvider>().fetchData();
    }  
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
final productAPI = Provider.of<ProductListAPIProvider>(context);
final SearchAPI = Provider.of<ProductListAPIProvider>(context);
    return  Scaffold(
     backgroundColor: Colors.white,
     body:  productAPI.ifLoading ? Center(child: CircularProgressIndicator()) :
     Padding(
       padding: const EdgeInsets.only(left: 15,right: 15),
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
        
       const SizedBox(height: 75),
        TextField(
        controller: searchController,
        onSubmitted: (String value) {
           //print("Check Search${searchController.text.toString()}");
           print(" ${value}");
           SearchAPI.searchData(value);

           },
         maxLines: 1,
        decoration: InputDecoration( 
          focusedBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
      enabledBorder:OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black87, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
           filled: true,      
           focusColor: Colors.red,
            hintText: "What do you want to buy today",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search,
                    color: Colors.grey),
                    onPressed: () {
                      print('Search');
                    },
                  ),
          border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
          ),
         
          hintStyle: TextStyle(color: Colors.grey[800]),
          
          fillColor: Colors.white70,
          
        ),
        ),
        const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Select Category",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black),
                ),
               
                   DropdownButton(
                    menuMaxHeight: 250.0,
            hint: Text('Please choose a location'), // Not necessary for Option 1
            value: _selectedLocation,
            onChanged: (newValue) {
              setState(() {
                _selectedLocation = newValue!;
              });
            },
            items: _locations.map((location) {
              return DropdownMenuItem(
                child:  Text(location),
                value: location,
              );
            }).toList(),
                   )
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 100,
              width: double.infinity,
              decoration:const BoxDecoration(
                 gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          
          colors: [
            Color.fromARGB(255, 135, 81, 61),
            Color.fromARGB(255, 39, 38, 38),
          ],
                 ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const Padding(
                    padding:  EdgeInsets.only(left: 15),
                    child: Text("Slash Sales begins in April. Get up to 80% ",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.white),),
                  ),
                  Row(
                    children: [
                     const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Discount on all Products ",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.white),),
                      ),
                       TextButton(onPressed: (){},
                  child: const Text("Read More",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                    ],
                  ),
                ],
              ),
            ),
           
              const SizedBox(height: 15),
           SearchAPI.productResponseModel!.products==null || SearchAPI.productResponseModel!.products.isEmpty?
           Center(
             child: const Text("No Products Found",
             style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
           )
             :Expanded(
                child: GridView.builder(
                itemCount:  productAPI.productResponseModel!.products.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  mainAxisSpacing: 25.0, 
                  crossAxisSpacing: 10.0, 
                ),
                padding: EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Card(
         semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                      image:DecorationImage(
                        image: NetworkImage(productAPI.productResponseModel!.products[index].images.first),
                      fit: BoxFit.cover)),
                ),
                Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        print("Added Your Favourites");
                      },
                      child: itsAdded == false
                          ? const Icon(Icons.favorite_outline,)
                          : const Icon(Icons.favorite),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text("${productAPI.productResponseModel!.products[index].category}",
                     style: TextStyle(fontSize: 12,color: Colors.black),
                    ),
                  ),
                  Text("${productAPI.productResponseModel!.products[index].description}",
                  overflow: TextOverflow.ellipsis,
                 style: TextStyle(fontSize: 12,color: Colors.black),),
                 Text("💲${productAPI.productResponseModel!.products[index].price}",
                 style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
            
                },
              ),
              ),
       ],
       ),
     ),
    );
  }
}