import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/addfood/food_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/bloc/addFood/add_food_bloc.dart';

class AddFood extends StatelessWidget {
  const AddFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
      ),
      body: BlocBuilder<AddFoodBloc, AddFoodState>(
        builder: (context, state) {
          if (state is AddFoodInitial) {
            BlocProvider.of<AddFoodBloc>(context).add(AddFoodLoadedEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddFoodLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddFoodErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AddFoodLoadedState) {
            return state.allProduct.isEmpty
                ? const Center(
                    child: Text('No data found'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.allProduct.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showFoodDesc(
                            context: context,
                            image: 'image',
                            name: state.allProduct[index].name,
                            ammount: 'per 100 grams',
                            description: state.allProduct[index].description,
                            calories: state.allProduct[index].calories,
                            carbs: state.allProduct[index].carbs,
                            protein: state.allProduct[index].protein,
                            fat: state.allProduct[index].fats,
                            sodium: state.allProduct[index].sodium,
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
                              style: TextStyle(color: whiteColor, fontSize: 16),
                            ),
                          ),
                          title: Text(
                            state.allProduct[index].name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Calories: ${state.allProduct[index].calories.toString()}',
                            style: TextStyle(fontSize: 14, color: calorieColor),
                          ),
                          trailing:
                              Icon(Icons.add_circle_outline, color: myBlue),
                        ),
                      );
                    },
                  );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
