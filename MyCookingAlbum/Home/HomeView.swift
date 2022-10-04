//
//  ContentView.swift
//  MyCookingAlbum
//
//  Created by Rio Nagasaki on 2022/10/01.
//

import SwiftUI
import ComposableArchitecture
import Combine

struct HomeView: View {
    @State var text:String = ""
    let store:Store<HomeState, HomeAction>
    var body: some View {
        WithViewStore(self.store){ viewStore in
            NavigationView{
                VStack(alignment: .leading){
                    Form{
                        RecipeSectionView(title: "メインディッシュ", recipes: viewStore.state.mainDishRecipes)
                        RecipeSectionView(title: "サイドディッシュ", recipes: viewStore.state.sideDishRecipes)
                        RecipeSectionView(title: "スープ", recipes: viewStore.state.soupRecipes)
                    }
                }.navigationTitle("料理記録アルバム")
            }.onAppear{
                viewStore.send(HomeAction.fetchRecipes)
            }
        }
    }
}

struct RecipeSectionView:View {
    let title:String
    var recipes:[Recipe]
    
    var body: some View{
        Text(title).font(.headline).padding(.leading,10)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(recipes){ recipe in
                    RecipeView(imageURL: recipe.imageURL,text: recipe.comment, createdAt: recipe.recordedAt)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeState.initial
    }
}
