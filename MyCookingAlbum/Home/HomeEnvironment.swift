//
//  HomeEnvironment.swift
//  MyCookingAlbum
//
//  Created by Rio Nagasaki on 2022/10/01.
//

import Foundation
import Combine
import ComposableArchitecture

struct HomeEnvironment {
    var mainQueue:AnySchedulerOf<DispatchQueue>
    var fact:(Int,Int) -> Effect<Recipes,APIError>
}

struct HomeApiClient {
    var effect: (Int,Int) -> Effect<Recipes,APIError>
}
extension HomeApiClient {
    static let live = HomeApiClient { offset, limit in
        let url = URL(string: "https://cooking-records.herokuapp.com/cooking_records?offset=\(offset)&limit=\(limit)")
        var request = URLRequest(url: url!)
        return URLSession.shared.dataTaskPublisher(for: request).tryMap { element in
            let httpResponse = (element.response as! HTTPURLResponse)
            if httpResponse.statusCode != 200 { throw APIError.badStatus(httpResponse.statusCode) }
            return element.data
        }.decode(type: Recipes.self, decoder: JSONDecoder()).mapError { error in
            return APIError.badRequest(error)
        }.eraseToEffect()
    }
}
