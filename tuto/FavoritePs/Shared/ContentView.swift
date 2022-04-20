//
//  ContentView.swift
//  Shared
//
//  Created by SamsungFireMobileiOS on 2022/02/17.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geo in
//            let imageWidth: CGFloat = (geo.size.width/2) - 40
            let imageWidth: CGFloat = (geo.size.width/2) - 30
            let imageHeight: CGFloat = imageWidth
            
            let buttonHeight: CGFloat = 40
                VStack(alignment: .leading, spacing: 0) {
                    VStack {
                        Divider()
                            .foregroundColor(.black)
                        HStack {
                            Text("대한민국 대선 온라인 투표 시스템")
//                            Text("요즘 내가 좋아하는 사람은?")
                                .font(.system(size: 25, weight: .bold, design: .default))
                                .foregroundColor(.black)
                        }
                        .frame(width: geo.size.width - 40, height: 40, alignment: .leading)
                        Divider()
                            .foregroundColor(.black)
                        ScrollView(showsIndicators: false) {
        //                HStack {
        //                    padding()
        //                    Text("요즘 내가 좋아하는 사람은?")
        //                    padding()
        //                }
        //                .frame(width: geo.size.width/2, height: 200, alignment: .center)
                        Spacer().frame(width: 10, height: 20, alignment: .leading)
                        
                        HStack(alignment: .center, spacing: 0) {
                            VStack {
                                Image("ps01")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                    .scaledToFill()
                                Button {
                                    showingAlert.toggle()
                                } label: {
                                 
                                    HStack {
                                        Text("이재명")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                            .opacity(1.0)
                                    }
                                    .background(Color.blue)
                                    .padding(.top, -16)
                                    .opacity(0.8)
                                }
                                .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                .alert(isPresented: $showingAlert) {
                                            Alert(title: Text("결과"), message: Text("이재명 을 투표하셨습니다.."), dismissButton: .default(Text("확인")))
                                        }
                                
                                Divider()
                                Text("324,232,12 명")
                                Text("남: 232,12 명")
                                Text("여: 32,12 명")
                                Text("비율: 42.02 %")
                            }
                            Spacer().frame(width: 20, height: 10, alignment: .leading)
                            VStack {
                                Image("ps02")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                    .scaledToFill()
                                Button {
                                    
                                } label: {
                                 
                                    HStack {
                                        Text("윤석열")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                            .opacity(1.0)
                                    }
                                    .background(Color.red)
                                    .padding(.top, -16)
                                    .opacity(0.8)
                                }
                                .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                Divider()
                                Text("124,232,12 명")
                                Text("남: 232,12 명")
                                Text("여: 32,12 명")
                                Text("비율: 32.02 %")
                            }
                        }
                        Divider()
                            .foregroundColor(.black)
                        HStack(alignment: .center, spacing: 0) {
                            VStack {
                                Image("ps03")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                    .scaledToFill()
                                Button {
                                    
                                } label: {
                                 
                                    HStack {
                                        Text("안철수")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                            .opacity(1.0)
                                    }
                                    .background(Color.green)
                                    .padding(.top, -16)
                                    .opacity(0.8)
                                }
                                .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                Divider()
                                Text("2,122 명")
                                Text("남: 232,12 명")
                                Text("여: 32,12 명")
                                Text("비율: 12.02 %")
                            }
                            Spacer().frame(width: 20, height: 10, alignment: .leading)
                            VStack {
                                Image("ps04")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                    .scaledToFill()
                                Button {
                                    
                                } label: {
                                 
                                    HStack {
                                        Text("심상정")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                            .opacity(1.0)
                                    }
                                    .background(Color.yellow)
                                    .padding(.top, -16)
                                    .opacity(0.8)
                                }
                                .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                Divider()
                                Text("2,123 명")
                                Text("남: 232,12 명")
                                Text("여: 32,12 명")
                                Text("비율: 6.02 %")
                            }
                        }
                        HStack(alignment: .center, spacing: 0) {
                            VStack {
                                Image("yj01")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                    .scaledToFill()
                                Button {
                                    
                                } label: {
                                 
                                    HStack {
                                        Text("욘자리")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                            .opacity(1.0)
                                    }
                                    .background(Color.pink)
                                    .padding(.top, -16)
                                    .opacity(0.8)
                                }
                                .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                Divider()
                                Text("12,322,122 명")
                                Text("남: 232,12 명")
                                Text("여: 32,12 명")
                                Text("비율: 99.02 %")
                            }
                            Spacer().frame(width: 20, height: 10, alignment: .leading)
                            VStack {
                                Image("iy01")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                    .scaledToFill()
                                Button {
                                    
                                } label: {
                                 
                                    HStack {
                                        Text("최일용")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                            .opacity(1.0)
                                    }
                                    .background(Color.gray)
                                    .padding(.top, -16)
                                    .opacity(0.8)
                                }
                                .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                Divider()
                                Text("2,123 명")
                                Text("남: 232,12 명")
                                Text("여: 32,12 명")
                                Text("비율: 6.02 %")
                            }
                        }
                        //------------------
                        HStack(alignment: .center, spacing: 0) {
                            VStack {
                                Image("yj02")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                    .scaledToFill()
                                Button {
                                    
                                } label: {
                                 
                                    HStack {
                                        Text("할배욘자리")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                            .opacity(1.0)
                                    }
                                    .background(Color.pink)
                                    .padding(.top, -16)
                                    .opacity(0.8)
                                }
                                .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                Divider()
                                Text("12,322,122 명")
                                Text("남: 232,12 명")
                                Text("여: 32,12 명")
                                Text("비율: 99.02 %")
                            }
                            Spacer().frame(width: 20, height: 10, alignment: .leading)
                            VStack {
                                Image("sy01")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                    .scaledToFill()
                                Button {
                                    
                                } label: {
                                 
                                    HStack {
                                        Text("황소연")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                            .opacity(1.0)
                                    }
                                    .background(Color.yellow)
                                    .padding(.top, -16)
                                    .opacity(0.8)
                                }
                                .frame(width: imageWidth, height: buttonHeight, alignment: .center)
                                Divider()
                                Text("2,123 명")
                                Text("남: 232,12 명")
                                Text("여: 32,12 명")
                                Text("비율: 6.02 %")
                            }
                        }
                        Spacer()
                        }
                        .padding(.top, -8)
                        
                    }
                    .frame(width: geo.size.width - 40, alignment: .center)
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
                .padding(EdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 1))
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
