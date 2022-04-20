//
//  ContentView.swift
//  Shared
//
//  Created by SamsungFireMobileiOS on 2022/02/17.
//

import SwiftUI

struct ContentView: View {
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
                    Image("ps1")
                        .resizable()
                        .frame(width: geo.size.width/2, height: 200, alignment: .center)
                    Spacer()
                    Image("ps2")
                        .resizable()
                        .frame(width: geo.size.width/2, height: 200, alignment: .center)
                }
                HStack(alignment: .center, spacing: 0) {
                    Image("ps3")
                        .resizable()
                        .frame(width: geo.size.width/2, height: 200, alignment: .center)
                    Spacer()
                    Image("ps4")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
