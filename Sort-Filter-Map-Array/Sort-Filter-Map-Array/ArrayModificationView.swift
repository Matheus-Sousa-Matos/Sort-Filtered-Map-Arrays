//
//  ArrayModificationView.swift
//  Sort-Filter-Map-Array
//
//  Created by Matheus de Sousa Matos on 07/10/22.
//
//  Credits:
//  https://www.youtube.com/watch?v=F-gUZztPTgI

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID()
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    
    ///Convert a type in another
    @Published var mappedArray: [String] = []

    public init() {
        getUsers()
        updateFilteredArray()
        updateMappedArray()
    }
    
    private func getUsers() {
        let user1 = UserModel(name: "Jhon", points: 50, isVerified: false)
        let user2 = UserModel(name: "Maria", points: 25, isVerified: true)
        let user3 = UserModel(name: "July", points: 75, isVerified: true)
        let user4 = UserModel(name: "Annie", points: 100, isVerified: true)
        let user5 = UserModel(name: "", points: 0, isVerified: false)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
        ])
    }
    
    private func updateFilteredArray() {
        // MARK: - Sort Array
//        filteredArray = dataArray.sorted(by: { user1, user2 in
//            return user1.points > user2.points
//        })
        //Compact form
//        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
        
        // MARK: - Filtered Array
//        filteredArray = dataArray.filter({ user in
//            return user.isVerified
//        })
        filteredArray = dataArray.filter( {$0.isVerified})
    }
    
    private func updateMappedArray() {
        // MARK: - Map Array
//        mappedArray = dataArray.map({ user in
//            return user.name
//        })
//        mappedArray = dataArray.map( {$0.name ?? "Empty"})
          ///Use compactMap if is optional values [?] , is very strong filter for remove nil and more.
//        mappedArray = dataArray.compactMap({ $0.name })
        
        //MARK: - Usign more one filter 
        ///Note: Is necessary compact map, because is string array
        mappedArray = dataArray
                        .sorted(by: { $0.points > $1.points })
                        .filter( {$0.isVerified})
                        .compactMap({ $0.name })
    }
}

struct ArrayModificationView: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack (spacing: 10) {
                
                Text("Filtered and Sort Array")
                    .font(.title).bold()
                
                ForEach(vm.filteredArray) { user in
                    VStack(alignment: .leading) {
                        Text(user.name ?? "a")
                            .font(.headline)
                        HStack {
                            Text("Points: \(user.points)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.purple.cornerRadius(15))
                    .padding(.horizontal)
                }
                
                Text("Map Array")
                    .font(.title).bold()
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.headline)
                }
                .foregroundColor(Color.white)
                .padding()
                .background(Color.blue.cornerRadius(15))
                .padding(.horizontal)
            }
        }
    }
}

struct ArrayModificationView_Previews: PreviewProvider {
    static var previews: some View {
        ArrayModificationView()
    }
}
