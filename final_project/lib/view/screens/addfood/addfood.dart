import 'dart:async';
import 'dart:developer';

import 'package:final_project/model/global_variables.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/addfood/food_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/bloc/addFood/add_food_bloc.dart';
import '../../../widgets/custom_titile.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  int selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchTimer;
  int? groupVal;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AddFoodBloc>(context)
        .add(AddFoodLoadedEvent(url: '/api/meals'));
    // BlocProvider.of<AddFoodBloc>(context)
    //     .add(AddFoodLoadedEvent(url1: '/api/customs/$userId'));
  }

  @override
  void dispose() {
    _searchController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<AddFoodBloc>(context)
            .add(AddFoodLoadedEvent(url: '/api/meals'));
        // BlocProvider.of<AddFoodBloc>(context)
        //     .add(AddFoodLoadedEvent(url1: '/api/customs/$userId'));
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const CustomTitle(
              fontSize: 25,
              isAppbar: true,
              title: "Add Food",
            ),
            leading: null,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextFormField(
                    autofocus: false,
                    controller: _searchController,
                    onChanged: (val) {
                      if (_searchTimer != null) {
                        _searchTimer!.cancel();
                      }

                      // Set a new timer to hit the API after a delay (e.g., 2 seconds)
                      _searchTimer = Timer(const Duration(seconds: 1), () {
                        if (val.isEmpty) {
                          _searchController.clear();
                          selectedIndex == 0
                              ? BlocProvider.of<AddFoodBloc>(context)
                                  .add(AddFoodLoadedEvent(url: '/api/meals'))
                              : BlocProvider.of<AddFoodBloc>(context).add(
                                  AddFoodLoadedEvent(url1: '/api/customs/0'));
                        } else {
                          selectedIndex == 0
                              ? BlocProvider.of<AddFoodBloc>(context).add(
                                  AddFoodLoadedEvent(
                                    url: '/api/meals?searchKey=$val',
                                  ),
                                )
                              : BlocProvider.of<AddFoodBloc>(context).add(
                                  AddFoodLoadedEvent(
                                    url1: '/api/customs/0?searchKey=$val',
                                  ),
                                );
                        }
                      });
                    },
                    onFieldSubmitted: (val) {
                      val == ''
                          ? {
                              _searchController.clear(),
                              selectedIndex == 0
                                  ? BlocProvider.of<AddFoodBloc>(context).add(
                                      AddFoodLoadedEvent(url: '/api/meals'))
                                  : BlocProvider.of<AddFoodBloc>(context).add(
                                      AddFoodLoadedEvent(
                                          url1: '/api/customs/$userId')),
                              FocusScope.of(context).unfocus(),
                            }
                          : {
                              FocusScope.of(context).unfocus(),
                              selectedIndex == 0
                                  ? BlocProvider.of<AddFoodBloc>(context).add(
                                      AddFoodLoadedEvent(
                                          url: '/api/meals?searchKey=$val'),
                                    )
                                  : BlocProvider.of<AddFoodBloc>(context).add(
                                      AddFoodLoadedEvent(
                                        url1:
                                            '/api/customs/$userId?searchKey=$val',
                                      ),
                                    ),
                            };
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: secondaryColor,
                      ),
                      hintText: 'Search Courses By Title',
                      hintStyle: TextStyle(
                        color: myGrey,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              secondaryColor, // this is the border color when focused
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 20),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          BlocProvider.of<AddFoodBloc>(context)
                              .add(AddFoodLoadedEvent(url: '/api/meals'));
                          _searchController.clear();
                        },
                        child: _searchController.text.isNotEmpty &&
                                _searchController.text != ''
                            ? const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 20,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  )),
            ),
          ),
          body: BlocBuilder<AddFoodBloc, AddFoodState>(
            builder: (context, state) {
              if (state is AddFoodInitial) {
                log('$state');
                BlocProvider.of<AddFoodBloc>(context)
                    .add(AddFoodLoadedEvent(url: '/api/meals'));
                // BlocProvider.of<AddFoodBloc>(context)
                //     .add(AddFoodLoadedEvent(url1: '/api/customs/$userId'));

                // } else if (state is AddFoodLoadingState) {
                //   log('$state');
                //   return const AddFoodShimmer();
              } else if (state is AddFoodErrorState) {
                log('$state');
                return Center(
                  child: Text(state.message),
                );
              } else if (state is AddFoodLoadedState) {
                log('$state');
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                                log('Selected Index: $selectedIndex');
                              });
                            },
                            child: Container(
                              decoration: selectedIndex == 0
                                  ? BoxDecoration(
                                      border: BorderDirectional(
                                        bottom: BorderSide(
                                          color: secondaryColor,
                                          width: 2,
                                        ),
                                      ),
                                    )
                                  : null,
                              child: Text('All Foods',
                                  style: TextStyle(
                                      fontSize: selectedIndex == 0 ? 20 : 16,
                                      color: selectedIndex == 0
                                          ? secondaryColor
                                          : Colors.black)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                                log('Selected Index: $selectedIndex');
                              });
                            },
                            child: Container(
                              decoration: selectedIndex == 1
                                  ? BoxDecoration(
                                      border: BorderDirectional(
                                        bottom: BorderSide(
                                          color: secondaryColor,
                                          width: 2,
                                        ),
                                      ),
                                    )
                                  : null,
                              child: Text('Premium Foods',
                                  style: TextStyle(
                                      fontSize: selectedIndex == 1 ? 20 : 16,
                                      color: selectedIndex == 1
                                          ? secondaryColor
                                          : Colors.black)),
                            ),
                          ),
                        ],
                      ),
                      selectedIndex == 0
                          ? state.allProduct.isEmpty
                              ? const Center(
                                  child: Text('No data found'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.allProduct.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        showFoodDesc(
                                          context: context,
                                          foodId: int.tryParse(state
                                              .allProduct[index].id
                                              .toString())!,
                                          image: 'image',
                                          name: state.allProduct[index].name,
                                          ammount: 'per 100 grams',
                                          description: state
                                              .allProduct[index].description,
                                          calories:
                                              state.allProduct[index].calories,
                                          carbs: state.allProduct[index].carbs,
                                          protein:
                                              state.allProduct[index].protein,
                                          fat: state.allProduct[index].fats,
                                          sodium:
                                              state.allProduct[index].sodium,
                                        );
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Text(
                                            getFirstandLastNameInitals(state
                                                .allProduct[index].name
                                                .toString()
                                                .toUpperCase()),
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 16),
                                          ),
                                        ),
                                        title: Text(
                                          state.allProduct[index].name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Calories: ${state.allProduct[index].calories.toString()}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: calorieColor),
                                        ),
                                        trailing: Icon(Icons.add_circle_outline,
                                            color: myBlue),
                                      ),
                                    );
                                  },
                                )
                          : state.premiumFood.isEmpty
                              ? const Center(
                                  child: Text('No data found'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.premiumFood.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        showFoodDesc(
                                          context: context,
                                          foodId: int.tryParse(state
                                              .allProduct[index].id
                                              .toString())!,
                                          image: 'image',
                                          name: state.premiumFood[index].name,
                                          ammount: 'per 100 grams',
                                          description: state
                                              .premiumFood[index].description,
                                          calories:
                                              state.premiumFood[index].calories,
                                          carbs: state.premiumFood[index].carbs,
                                          protein:
                                              state.premiumFood[index].protein,
                                          fat: state.premiumFood[index].fats,
                                          sodium:
                                              state.premiumFood[index].sodium,
                                        );
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Text(
                                            getFirstandLastNameInitals(state
                                                .allProduct[index].name
                                                .toString()
                                                .toUpperCase()),
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 16),
                                          ),
                                        ),
                                        title: Text(
                                          state.premiumFood[index].name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Calories: ${state.premiumFood[index].calories.toString()}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: calorieColor),
                                        ),
                                        trailing: Icon(Icons.add_circle_outline,
                                            color: myBlue),
                                      ),
                                    );
                                  },
                                ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
