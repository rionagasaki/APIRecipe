//
//  RecipeView.swift
//  MyCookingAlbum
//
//  Created by Rio Nagasaki on 2022/10/01.
//

import SwiftUI

struct RecipeView: View {
    @State private var showingSheet:Bool = false
    let imageURL:String
    let text:String
    let createdAt:String
    var body: some View {
        ZStack(alignment: .bottom){
            AsyncImage(url: URL(string: imageURL))
            VStack(alignment: .trailing){
                Button {
                    self.showingSheet.toggle()
                } label: {
                    Image(systemName: "info.circle").foregroundColor(.white).font(.title)
                }.padding(.trailing,13).padding(.top,20).sheet(isPresented: $showingSheet) {
                    DetailView(imageURL: imageURL, text: text, createdAt: createdAt)
                }
                Spacer()
                Text(text).font(.system(size: 15)).font(.footnote).foregroundColor(.white).frame(width: 220, height: 100).background(.gray).opacity(0.8)
            }
        }.frame(width: 220, height: 260).cornerRadius(20)
    }
}

struct DetailView:View {
    let imageURL:String
    let text: String
    let createdAt:String
    
    var body: some View{
        NavigationView{
            VStack(alignment: .center){
                AsyncImage(url: URL(string: imageURL)).cornerRadius(10)
                Text(text).font(.body).frame(width:200)
                Text(createdAt).font(.footnote).foregroundColor(.gray)
                Spacer()
            }.navigationTitle("詳細")
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(imageURL: "",text: "ここにコメントが入ります。", createdAt: "2022/10/4")
    }
}
