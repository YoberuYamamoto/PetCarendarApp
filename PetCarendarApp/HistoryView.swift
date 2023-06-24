//
//  HistoryView.swift
//  PetCarendarApp
//
//  Created by 山本預言留 on 2023/06/24.
//

import SwiftUI

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
struct HistoryView: View {
    
    
    @AppStorage("records") private var recordsData: Data = Data()
    @State private var records: [Record] = []
    
    var body: some View {
        VStack {
            Text("履歴")
            List {
                ForEach(records) { record in
                    Text(record.date)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    Text(record.petName)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    Text(record.food1)
                    Text("\(record.count1)")
                    Text(record.food2)
                    Text("\(record.count2)")
                    Text(record.food3)
                    Text("\(record.count3)")
                }
            }
        }
        
        .onAppear {
            do {
                let decoder = JSONDecoder()
                records = try decoder.decode([Record].self, from: recordsData)
            } catch {
                print("Failed to decode records: \(error)")
            }
        }
    }
}
        
        struct HistoryView_Previews: PreviewProvider {
            static var previews: some View {
                HistoryView()
            }
        }
    
