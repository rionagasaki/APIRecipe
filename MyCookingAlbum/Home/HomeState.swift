//
//  HomeState.swift
//  MyCookingAlbum
//
//  Created by Rio Nagasaki on 2022/10/01.
//

import Foundation
import ComposableArchitecture

struct HomeState:Equatable{
    var mainDishRecipes:[Recipe] = []
    var sideDishRecipes:[Recipe] = []
    var soupRecipes:[Recipe] = []
    static var initial:HomeView {
        HomeView(store: Store(initialState: HomeState(), reducer: HomeReducer.reducer, environment: HomeEnvironment(mainQueue: .main, fact: HomeApiClient.live.effect)))
    }
}

public struct Recipes:Decodable{
    var cookingRecords:[Recipe]
    
    enum CodingKeys:String, CodingKey{
        case cookingRecords = "cooking_records"
    }
}

public struct Recipe:Decodable,Hashable,Identifiable {
    public var id = UUID().uuidString
    var imageURL:String
    var comment:String
    var recipeType:String
    var recordedAt:String
    
    enum CodingKeys:String, CodingKey{
        case imageURL = "image_url"
        case comment
        case recipeType = "recipe_type"
        case recordedAt = "recorded_at"
    }
}
