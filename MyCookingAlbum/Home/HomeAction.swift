//
//  HOmeAction.swift
//  MyCookingAlbum
//
//  Created by Rio Nagasaki on 2022/10/01.
//

import Foundation
import ComposableArchitecture
import AVFoundation

enum HomeAction {
    case fetchRecipes
    case apiResponse(Result<Recipes,APIError>)
}

enum APIError:Error{
    case badStatus(Int)
    case badRequest(Error)
}
