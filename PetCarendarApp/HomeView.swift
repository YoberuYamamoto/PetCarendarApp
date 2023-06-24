//
//  HomeView.swift
//  PetCarendarApp
//
//  Created by 山本預言留 on 2023/06/24.
//

import SwiftUI

struct HiddenTextField: View {
    @Binding var currentDate: String
    @State private var hiddenText = ""

    var body: some View {
        TextField("", text: $hiddenText)
            .hidden()
            .onChange(of: hiddenText) { newValue in
            currentDate = newValue
            }
    }
}

struct HomeView: View {
    
    @AppStorage("records") private var recordsData: Data = Data()
    
    @State var FoodCount1 :Int = 0
    @State var FoodCount2 :Int = 0
    @State  var FoodCount3 :Int = 0
    
    @State private var userInputFood1 = ""
    @State private var userInputFood2 = ""
    @State private var userInputFood3 = ""
    
    @State private var userInputpet = ""
    
    @State private var currentDate = ""
    
    @State private var records: [Record] = []
    
    func resetForm() {
        FoodCount1 = 0
        FoodCount2 = 0
        FoodCount3 = 0
    }
    
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
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        self.currentDate = dateFormatter.string(from: Date())
    }

    @AppStorage("lastRecordDate") private var lastRecordDate: String = "なし"

    var body: some View {
        VStack {
           
            Text(currentDate)
                .font(.system(size: 20))
                .fontWeight(.bold)
                
            HiddenTextField(currentDate: $currentDate)
            
            
            TextField("ペットの名前", text: $userInputpet)
                .font(.system(size: 30))
                .frame(maxWidth: .maximum(350, 20), alignment: .leading)
                
            
            Text("前回の餌やり：\(lastRecordDate)")
                .font(.system(size: 15))
                .frame(maxWidth: .maximum(350, 20), alignment: .leading)
            
            HStack {
                VStack {
                    TextField("餌の種類", text: $userInputFood1)
                        .multilineTextAlignment(.center)
                    HStack {
                        
                        Button {
                            FoodCount1 += 1
                        } label: {
                            Text("+")
                        }
                        Text(String(FoodCount1))
                        Button{
                            if FoodCount1 > 0 {
                                FoodCount1 -= 1
                            }
                        } label: {
                            Text("-")
                        }
                    } //HStackここまで
                }//VStackここまで
                Spacer().frame(width: 30)
                
                VStack {
                    TextField("餌の種類", text: $userInputFood2)
                        .multilineTextAlignment(.center)
                    HStack {
                        Button {
                            FoodCount2 += 1
                        } label: {
                            Text("+")
                        }
                        Text(String(FoodCount2))
                        Button{
                            if FoodCount2 > 0 {
                                FoodCount2 -= 1
                            }
                        } label: {
                            Text("-")
                        }
                    }//HStackここまで
                } //VStackここまで
                
                Spacer().frame(width: 30)
                VStack {
                    TextField("餌の種類", text: $userInputFood3)
                        .multilineTextAlignment(.center)
                    HStack {
                        Button {
                            FoodCount3 += 1
                        } label: {
                            Text("+")
                        }
                        Text(String(FoodCount3))
                        Button {
                            if FoodCount3 > 0 {
                                FoodCount3 -= 1
                            }
                        } label: {
                            Text("-")
                        }
                    } //HStackここまで
                } //VStackここまで
                .onAppear {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy年MM月dd日"
                            self.currentDate = dateFormatter.string(from: Date())
                        }
            } //HStackここまで
            
            Button(action: {
                           saveRecord()
                       }, label: {
                           Text("記録する")
                               .font(.system(size: 20))
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                               .padding()
                               .background(Color.blue)
                               .cornerRadius(10)
                       })
                       .padding(.top, 20)
        } //VStackここまで
      
    } //bodyここまで
    private func saveRecord() {
           let record = Record(date: currentDate, petName: userInputpet, food1: userInputFood1, count1: FoodCount1, food2: userInputFood2, count2: FoodCount2, food3: userInputFood3, count3: FoodCount3)
           records.append(record)
        
        do {
                   let encoder = JSONEncoder()
                   let recordsData = try encoder.encode(records)
                   self.recordsData = recordsData
        }
        catch {
                   print("Failed to encode records: \(error)")
        }
              
               // データを保存した後にフォームをリセットする
               resetForm()
        lastRecordDate = currentDate
    }
    
} //HomeViewここまで

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
