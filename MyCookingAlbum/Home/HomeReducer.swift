//
//  HomeReducer.swift
//  MyCookingAlbum
//
//  Created by Rio Nagasaki on 2022/10/01.
//

import Foundation
import ComposableArchitecture

struct HomeReducer {
    static let reducer = Reducer<HomeState, HomeAction, HomeEnvironment>{ state, action, environment in
        switch action {
            
        case .fetchRecipes:
            return environment.fact(0,100).receive(on: environment.mainQueue).catchToEffect().map(HomeAction.apiResponse)
        case let .apiResponse(.success(recipes)):
            recipes.cookingRecords.forEach { recipe in
                if recipe.recipeType == Recipe_Type.mainDish.rawValue{
                    state.mainDishRecipes.append(recipe)
                }else if recipe.recipeType == Recipe_Type.sideDish.rawValue{
                    state.sideDishRecipes.append(recipe)
                }else{
                    state.soupRecipes.append(recipe)
                }
            }
            return .none
        case let .apiResponse(.failure(error)):
            print(error)
            return .none
        }
    }
}

enum Recipe_Type:String{
    case mainDish = "main_dish"
    case sideDish = "side_dish"
    case soup = "soup"
}
