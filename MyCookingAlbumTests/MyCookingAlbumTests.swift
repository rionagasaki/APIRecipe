//
//  MyCookingAlbumTests.swift
//  MyCookingAlbumTests
//
//  Created by Rio Nagasaki on 2022/10/02.
//

import XCTest
import ComposableArchitecture

@testable import MyCookingAlbum

class MyCookingAlbumTests: XCTestCase {
    let store = TestStore(initialState: HomeState(), reducer: HomeReducer.reducer, environment: HomeEnvironment(mainQueue: DispatchQueue.immediate.eraseToAnyScheduler(), fact: { result, error in
        return Effect(value: Recipes(cookingRecords: [Recipe(id: UUID().uuidString, imageURL: "", comment: "", recipeType: "", recordedAt: "")]))
    }))
    
    func test_fetch(){
        store.send(.apiResponse(.success(Recipes(cookingRecords: [Recipe(id: "aaa", imageURL: "", comment: "", recipeType: Recipe_Type.mainDish.rawValue, recordedAt: ""), Recipe(id: "bbb", imageURL: "", comment: "", recipeType: Recipe_Type.soup.rawValue, recordedAt: "")])))){ result in
            result.mainDishRecipes = [Recipe(id: "aaa", imageURL: "", comment: "", recipeType: Recipe_Type.mainDish.rawValue, recordedAt:"")]
            result.soupRecipes = [Recipe(id: "bbb", imageURL: "", comment: "", recipeType: Recipe_Type.soup.rawValue, recordedAt: "")]
        }
    }
}
