import 'package:flutter/material.dart';
import 'package:meals_app/data/screens/categories.dart';
import 'package:meals_app/data/screens/fliters.dart';
import 'package:meals_app/data/screens/meals.dart';

import 'package:meals_app/wigdets/main_drawer.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabScreenState();
  }
}


class _TabScreenState extends ConsumerState<TabsScreen> {
  int _selcetedPageIndex = 0;
  
 
    

  void _showInfoMessage(String message) {
   
  }

  

  void _selcetPage(int index) {
    setState(() {
      _selcetedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
      if(identifier== 'filters') {
        await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (ctx) => const FiltersScreen(
           ),
          ),
        );
        
        
       }
     
  }

  @override
  Widget build(BuildContext context) {
    
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage=  CategoriesScreen
    (
      availableMeals: availableMeals,
    );
    var activePageTitle= 'Categories';

    if(_selcetedPageIndex ==1) {
      final favoriteMeals = ref.watch(favoritesMealsProvider);
      activePage =   MealsScreen(
        meals: favoriteMeals, 
        
      );
      activePageTitle= 'Your Favorites';
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer:  MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selcetPage,
        currentIndex: _selcetedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories',),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites',),
        ],
      ),
    );
  }

}