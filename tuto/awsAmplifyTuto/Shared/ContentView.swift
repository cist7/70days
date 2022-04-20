//
//  ContentView.swift
//  Shared
//
//  Created by SamsungFireMobileiOS on 2022/01/19.
//

//import Amplify
//import AWSAPIPlugin
//import AWSDataStorePlugin


import SwiftUI

struct MemoryRow: View {
    
    @State var name: String = "name"
    @State var date: String = "2022.01.12"
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(date)
        }
        
    }
}

struct ContentView: View {
//    @Binding var memoryList: []
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var memoryList: MemoryList  //= MemoryList()
    
    @State var memoryName: String = "yong"
//    @State var memoryList: [String] = ["123","44","33"]
    
    func saveMemory(name: String) {
        self.appDelegate.saveMemory(name: name)
//        name = ""
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                HStack {
                    padding()
                    Text("요즘 내가 좋아하는 사람은?")
                        .padding()
                    padding()
                }
                .frame(width: geo.size.width/2, height: 200, alignment: .center)
                Spacer()
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "circle")
                        .resizable()
                        .frame(width: geo.size.width/2, height: 200, alignment: .center)
                    Spacer()
                    Image(systemName: "circle")
                        .resizable()
                        .frame(width: geo.size.width/2, height: 200, alignment: .center)
                    
                }
            
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .onAppear {
            }
        }
    }
}

//struct ContentView: View {
////    @Binding var memoryList: []
//
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//
//    @ObservedObject var memoryList: MemoryList  //= MemoryList()
//
//    @State var memoryName: String = "yong"
////    @State var memoryList: [String] = ["123","44","33"]
//
//    func saveMemory(name: String) {
//        self.appDelegate.saveMemory(name: name)
////        name = ""
//    }
//    var body: some View {
//        GeometryReader { geo in
//            VStack {
//                HStack {
//                    padding()
//                    Text("요즘 내가 좋아하는 사람은?")
//                        .padding()
//                    padding()
//                }
//                .frame(width: geo.size.width/2, height: 200, alignment: .center)
////                HStack {
////                    TextField("input", text: $memoryName)
////                    Spacer()
////                    Button {
////                        saveMemory(name: memoryName)
////                        memoryName = ""
////                    } label: {
////                        Text("저장")
////                    }
////
////                }
//                Spacer()
//                HStack(alignment: .center, spacing: 0) {
//                    Image(systemName: "circle")
//                        .resizable()
//                        .frame(width: geo.size.width/2, height: 200, alignment: .center)
//                    Spacer()
//                    Image(systemName: "circle")
//                        .resizable()
//                        .frame(width: geo.size.width/2, height: 200, alignment: .center)
//
//                }
////                ScrollView {
////    //                ForEach(memoryList.memoryList, id: \.self) { memory in
////                    ForEach(memoryList.memoryList) { memory in
////                        MemoryRow(name: memory.name!, date: "2022.01.12")
////                            .frame(height :40)
////                    }
////                }
//            }
//            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//            .onAppear {
//    //            appDelegate.listMemories()
//    //            self.$memoryList.memoryList.wrappedValue = appDelegate.memoryList.memoryList
//    //            self.memoryList = self.appDelegate.memoryList
//            }
//        }
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
