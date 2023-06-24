//
//  ContentView.swift
//  PetCarendarApp
//
//  Created by 山本預言留 on 2023/06/24.
//

import SwiftUI

struct ContentView: View {
   
    struct Record: Codable,Identifiable {
           var id = UUID()
           var date: String
           var petName: String
           var food1: String
           var count1: Int
           var food2: String
           var count2: Int
           var food3: String
           var count3: Int
       }
    
    var body: some View {
        
        TabView{
            HomeView()
                .tabItem{
                    Text("エサやり記録")
                }
            HistoryView()
                .tabItem{
                    Text("餌やり履歴")
                }

        }//TabViewここまで
    } //bodyここまで
} //ContentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
