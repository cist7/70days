//
//  ContentView.swift
//  Shared
//
//  Created by SamsungFireMobileiOS on 2022/04/19.
//

import SwiftUI
import Foundation
import Combine
import WebKit

class WebViewModel: ObservableObject {
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
}

struct WebView: UIViewRepresentable {
    var url: String
    @ObservedObject var viewModel: WebViewModel
    
    // 변경 사항을 전달하는 데 사용하는 사용자 지정 인스턴스를 만듭니다.
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // 뷰 객체를 생성하고 초기 상태를 구성합니다. 딱 한 번만 호출됩니다.
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false  // JavaScript가 사용자 상호 작용없이 창을 열 수 있는지 여부
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator    // 웹보기의 탐색 동작을 관리하는 데 사용하는 개체
        webView.allowsBackForwardNavigationGestures = true    // 가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리거하는지 여부
        webView.scrollView.isScrollEnabled = true    // 웹보기와 관련된 스크롤보기에서 스크롤 가능 여부
        
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))    // 지정된 URL 요청 개체에서 참조하는 웹 콘텐츠를로드하고 탐색
        }
        
        return webView
    }
    
    // 지정된 뷰의 상태를 다음의 새 정보로 업데이트합니다.
    func updateUIView(_ webView: WKWebView, context: Context) {
//        ...
    }
    
    // 탐색 변경을 수락 또는 거부하고 탐색 요청의 진행 상황을 추적
    class Coordinator : NSObject, WKNavigationDelegate {
//        ...
    }
}

class Coordinator : NSObject, WKNavigationDelegate {
    var parent: WebView
    var foo: AnyCancellable? = nil
    
    // 생성자
    init(_ uiWebView: WebView) {
        self.parent = uiWebView
    }

    // 소멸자
    deinit {
        foo?.cancel()
    }
    
    // 지정된 기본 설정 및 작업 정보를 기반으로 새 콘텐츠를 탐색 할 수있는 권한을 대리인에게 요청
    func webView(_ webView: WKWebView,
                   decidePolicyFor navigationAction: WKNavigationAction,
                   decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            // 특정 도메인을 제외한 도메인을 연결하지 못하게 할 수 있다.
            if host != "velog.io" {
               return decisionHandler(.cancel)
           }
        }
        
        // bar에 값을 send 해보자!
        parent.viewModel.bar.send(false)
        
        // foo로 값이 receive 되면 출력해보자!
        self.foo = self.parent.viewModel.foo.receive(on: RunLoop.main)
                                            .sink(receiveValue: { value in
            print(value)
        })
        
        return decisionHandler(.allow)
    }
     
    // 기본 프레임에서 탐색이 시작되었음
    func webView(_ webView: WKWebView,
                   didStartProvisionalNavigation navigation: WKNavigation!) {
        print("기본 프레임에서 탐색이 시작되었음")
    }
    
    // 웹보기가 기본 프레임에 대한 내용을 수신하기 시작했음
    func webView(_ webView: WKWebView,
                   didCommit navigation: WKNavigation!) {
        print("내용을 수신하기 시작");
    }
    
    // 탐색이 완료 되었음
    func webView(_ webview: WKWebView,
                   didFinish: WKNavigation!) {
        print("탐색이 완료")
    }
    
    // 초기 탐색 프로세스 중에 오류가 발생했음 - Error Handler
    func webView(_ webView: WKWebView,
                   didFailProvisionalNavigation: WKNavigation!,
                   withError: Error) {
        print("초기 탐색 프로세스 중에 오류가 발생했음")
    }
    
    // 탐색 중에 오류가 발생했음 - Error Handler
    func webView(_ webView: WKWebView,
                   didFail navigation: WKNavigation!,
                   withError error: Error) {
        print("탐색 중에 오류가 발생했음")
    }
}

struct BottomMenuBarFlexibleView: View {
    @Binding var isFavoriteToggleOn: Bool
    @Binding var addressStr: String
    @Binding var webViewFlexibleHeight: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
//                        Text(bar ? "Before" : "After")
                Spacer()
                HStack {
                    HStack {
                        Button(action: {
    //                            self.viewModel.foo.send(true)
                        }) {
                            Text("<")
                        }
                        Spacer()
                            .frame(width: 30, height: 10)
                        Button(action: {
    //                            self.viewModel.foo.send(true)
                        }) {
                            Text(">")
                        }
                    }
                    .frame(width: 70, height: 30, alignment: .center)
                    Spacer()
                    Button(action: {
    //                        self.viewModel.foo.send(true)
                    }) {
    //                    Text("Address")
                        TextField("Input Address", text: $addressStr)
                    }
                    Spacer()
                    Button(action: {
    //                        self.viewModel.foo.send(true)
                    }) {
                        Text("Refresh")
                    }
                    Spacer()
                    Button(action: {
    //                        self.viewModel.foo.send(true)
    //                        favoriteToggleOn.toggle()
                        self.$isFavoriteToggleOn.wrappedValue.toggle()
                    }) {
                        Text("Favorite")
                    }
                }
                .padding(.top, 10)
                .font(.system(size: 14, weight: .regular, design: .default))
//                .font(Font.system(size: 10, weight: .regular, design: Font.Design.default)
                .foregroundColor(.white)
                Spacer()
            }
            .frame(height: 60, alignment: .center)
//            .background(.white)
            .background(.gray)
            .cornerRadius(10)
            .padding(.top, -10)
            .clipped()
            HStack {
                Button {
//                        Text("=")
                    $webViewFlexibleHeight.wrappedValue = $webViewFlexibleHeight.wrappedValue + 10
                } label: {
                    VStack {
                        Text("===").foregroundColor(Color.black)
//                        Text("===").foregroundColor(Color.black)
                    }
                    .padding(.top, -10)
                }
            }
            .frame(height: 20, alignment: .center)
            .background(.clear)
        }
        .frame(height: 70, alignment: .center)
    }
}

struct BottomMenuBarView: View {
    @Binding var isFavoriteToggleOn: Bool
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
//                        Text(bar ? "Before" : "After")
                    Spacer()
                    HStack {
                        Button(action: {
//                            self.viewModel.foo.send(true)
                        }) {
                            Text("<")
                        }
                        Spacer()
                        Button(action: {
//                            self.viewModel.foo.send(true)
                        }) {
                            Text(">")
                        }
                    }
                    .frame(width: 70, height: 30, alignment: .center)
                    Spacer()
                    Button(action: {
//                        self.viewModel.foo.send(true)
                    }) {
                        Text("Address")
                    }
                    Spacer()
                    Button(action: {
//                        self.viewModel.foo.send(true)
                    }) {
                        Text("Refresh")
                    }
                    Spacer()
                    Button(action: {
//                        self.viewModel.foo.send(true)
//                        favoriteToggleOn.toggle()
                        self.$isFavoriteToggleOn.wrappedValue.toggle()
                    }) {
                        Text("Favorite")
                    }
                    Spacer()
                }
                .frame(height: 20, alignment: .center)
                .background(.black)
                .opacity(0.5)
            }
        }
    }
}


struct FavoriteListView: View {

    @Binding var isCloseButtonToggleOn:Bool
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        $isCloseButtonToggleOn.wrappedValue = false
                    } label: {
                        Text("CLOSE")
                    }
                }
            }
            .frame(height: 40, alignment: .leading)
            
            VStack {
//                ForEach(1...10) {
                
                HStack {
                    Text("www.naver.com")
                    Spacer()
                }
                .frame(height: 50, alignment: .leading)
                HStack {
                    Text("www.daum.com")
                    Spacer()
                }
                .frame(height: 50, alignment: .leading)
                HStack {
                    Text("cryptowat.ch")
                    Spacer()
                }
                .frame(height: 50, alignment: .leading)
                HStack {
                    Text("cistree.net")
                    Spacer()
                }
                .frame(height: 50, alignment: .leading)
                HStack {
                    Text("samsungfire.com")
                    Spacer()
                }
                .frame(height: 50, alignment: .leading)
                
//                }
            }
        }
    }
}

func geometryProxy(_ geometry: GeometryProxy) -> some View {
  let size = geometry.size
  return Text("Hello world")
    .frame(width: size.width, height: size.height, alignment: .top)
}

struct BottomNavigationBarView: View {
    
    @State var webViewID: String = "1"
    @State var themeColor: Color = Color.black
    
    @Binding var isFavoriteToggleOn: Bool
    @Binding var webViewFlexibleHeight: CGFloat
    @Binding var searchText: String
    @Binding var isCloseButtonToggleOn:Bool
    
    var iconWidth: CGFloat = 30.0
    var body: some View {
//        GeometryReader { geo in
//        VStack {
//            Spacer()
            HStack {
                HStack(spacing: 10) {
                    Spacer()
                    Button {
                    } label: {
                        Image(systemName: "arrow.left.circle").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                    }
                    Button {
                    } label: {
                        Image(systemName: "arrow.right.circle").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                    }
                    TextField("Search", text: $searchText)
//                        .frame(width: geo.size.width - (50*5) , height: 35, alignment: .leading)
                        .frame(height: 35, alignment: .leading)
//                        .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2))
                    Button {
                    } label: {
                        Image(systemName: "arrow.clockwise").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                     
                    }
                    Button {
                        isFavoriteToggleOn.toggle()
                    } label: {
                        Image(systemName: isFavoriteToggleOn ? "bookmark.circle.fill" : "bookmark.circle").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                     
                    }
                    Button {
                        $isCloseButtonToggleOn.wrappedValue = true
                    } label: {
                        Image(systemName: "xmark.circle").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                    }
                    Spacer()
                }
                .padding(.top, 10)
                
            }
//            .frame(width: geo.size.width - 20, height: 60, alignment: .leading)
            .frame(height: 60, alignment: .leading)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .background(themeColor)
//            .background(.black)
            .cornerRadius(10)
            .padding(.top, -10)
            .clipped()
        }
        
//    }
//    }
}

//VStack(spacing: 0) {
//
//    VStack(spacing: 0) {
//
//        WebView(url: "https://cryptowat.ch/ko/charts/BINANCE:BTC-USDT?period=5m", viewModel: viewModel)
////                                    BottomMenuBarFlexibleView(isFavoriteToggleOn: $isTopFavoriteToggleOn, addressStr: $addrString, webViewFlexibleHeight: $webViewDefaultHeight)
////                                        .background(.clear)
//        BottomNavigationBarView(isFavoriteToggleOn: $isFavoriteToggleOn, webViewFlexibleHeight: $webViewDefaultHeight, searchText: $addrString, isCloseButtonToggleOn: $isTopFavoriteToggleOn)
//            .background(.clear)
//
//    }
//}
//.cornerRadius(10)
//.clipped()
//.background(webViewBgColor)
//.frame(width: geo.size.width - 20, height: webViewDefaultHeight, alignment: .center)

struct WebViewBox: View {
    
//    @ObservedObject
    @State var viewModel: WebViewBoxModel
    @ObservedObject var webViewModel: WebViewModel = WebViewModel()
//    @Binding var isCloseButtonToggleOn: Bool
    @State var isCloseButtonToggleOn: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
        
//                WebView(url: "https://cryptowat.ch/ko/charts/BINANCE:BTC-USDT?period=5m", viewModel: viewModel)
                WebView(url: viewModel.addressStr, viewModel: webViewModel)
                    .cornerRadius(10)
//                    .border(viewModel.themeColor, width: 2)
                BottomNavigationBarView(themeColor: viewModel.themeColor, isFavoriteToggleOn: $viewModel.isFavorite, webViewFlexibleHeight: $viewModel.webViewFlexibleHeight, searchText: $viewModel.searchText, isCloseButtonToggleOn: $isCloseButtonToggleOn)
                    .background(.clear)
        
            }
        }
        .cornerRadius(10)
        .clipped()
        .background(viewModel.webViewBgColor)
//        .frame(width: geo.size.width - 20, height: viewModel.webViewFlexibleHeight, alignment: .center)
    }
}

// MARK: - ViewModel
class WebViewBoxModel: ObservableObject, Identifiable {
    private var webViewID: String = "" //UUID()
    
    var addressStr: String = "https://www.naver.com"
    var isFavorite: Bool = false
    var webViewFlexibleHeight: CGFloat = 500
    var searchText: String = ""
    var webViewBgColor: Color = .clear
    var themeColor: Color = .gray
//    private var isCloseButtonToggleOn:Bool
    
    init(urlAddressString: String, viewHeight: CGFloat = 500, isFavorite: Bool = false, themeColor: Color = Color(red: 255/255, green: 182/255, blue: 193/255)) {
        self.webViewID = UUID().uuidString
        self.addressStr = urlAddressString
        self.webViewFlexibleHeight = viewHeight
        self.isFavorite = isFavorite
        self.themeColor = themeColor
    }

    
//    var disposeBag = DisposeBag()
//
//    private let errorSubject: PublishSubject<ResultError?> = .init()
//
//    init() {
//    }
//
//    deinit {
//        logg.verbose("\(String(describing: self)) disposed")
//    }
//
//    var inputs: HogaViewModelInputs { self }
//    var outputs: HogaViewModelOutputs { self }
}

// MARK: - Outputs
extension WebViewBoxModel {
}
 
struct ContentView: View {
    
    @ObservedObject var viewModel = WebViewModel()
    @State var bar = true
    @State var isPresention = false
    @State var isFavoriteToggleOn:Bool = false
    @State var isTopFavoriteToggleOn:Bool = false
    @State var isBottomFavoriteToggleOn:Bool = false
    
    @State var webViewDefaultHeight: CGFloat = 470
    @State var webViewBgColor: Color = .clear
    
    @State var addrString: String = ""
//    @State var webViewList: [WebViewBox] = [WebViewBox(isCloseButtonToggleOn: false)
//                                            ,WebViewBox(isCloseButtonToggleOn: false)
//                                            ,WebViewBox(isCloseButtonToggleOn: false)
//                                            ,WebViewBox(isCloseButtonToggleOn: false)
//                                            ,WebViewBox(isCloseButtonToggleOn: false)
//                                            ,WebViewBox(isCloseButtonToggleOn: false)
//    ]
    @State var webViewModelList: [WebViewBoxModel] = [WebViewBoxModel(urlAddressString: "https://cryptowat.ch/ko/charts/BINANCE:BTC-USDT?period=5m", viewHeight: 400, isFavorite: false)
                                            ,WebViewBoxModel(urlAddressString: "https://cryptowat.ch/ko/charts/BINANCE:BTC-USDT?period=1h", viewHeight: 400, isFavorite: false)
                                                      ,WebViewBoxModel(urlAddressString: "https://cryptowat.ch/ko/charts/BINANCE:BTC-USDT?period=1d", viewHeight: 800, isFavorite: false)
                                                      ,WebViewBoxModel(urlAddressString: "https://www.daum.net", viewHeight: 300, isFavorite: false)
                                                      ,WebViewBoxModel(urlAddressString: "https://www.naver.com", viewHeight: 400, isFavorite: false)
                                                      ,WebViewBoxModel(urlAddressString: "https://www.youtube.com", viewHeight: 500, isFavorite: false)
    ]
    
    var currentBgColor: Color = Color.white
    var iconWidth: CGFloat = 30
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    ZStack {
                    ScrollView {
//                        ForEach(webViewList, id: \.self) {
                        ForEach(webViewModelList) {
//                            WebViewBox(viewModel: $0, isCloseButtonToggleOn: false)
                            WebViewBox(viewModel: $0)
                            .frame(width: geo.size.width - 20, height: $0.webViewFlexibleHeight, alignment: .center)
//                            .padding(.leading, 10)
//                            Text($0.asComma)
//                                .foregroundColor(Color(Asset.text.color))
//                                .background(Color(Asset.background.color))
//                                .frame(height: 100)
                        }

                    }
//                    .padding(.bottom, 50)
//                        Text(" ").frame(height: 150)
//                    Spacer().frame(height: 0)
                    
                        ZStack {
                            
                        VStack {
                            Spacer()
                            VStack {
                                HStack {
                                    Spacer()
            //                        Button {
            //                        } label: {
            //                            Image(systemName: "arrow.left.circle").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
            //                        }
                                    Button {
                                    } label: {
            //                            Image(systemName: "rectangle.grid.1x2").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                                        Image(systemName: "square.stack").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                                    }
                                    Spacer()
                                    Button {
                                    } label: {
            //                            Image(systemName: "plus").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                                        Image(systemName: "plus.square.on.square").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                                    }
            //                        Button {
            //                        } label: {
            //                            Image(systemName: "tray.full").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
            //                        }
                                    Spacer()
                                    Button {
                                    } label: {
                                        Image(systemName: "gear").resizable().frame(width: iconWidth, height: iconWidth, alignment: .center)
                                    }
                                    Spacer()
                                }
                                .foregroundColor(.white)
                                
                            }
                            .frame(height: 50, alignment: .center)
//                            .opacity(0.5)
                            .background(.gray)
                        }
                        }.opacity(0.7)
                    }
                    
                }
                .background(currentBgColor)
                .frame(alignment: .center)
            }
            .background(currentBgColor)
            .frame(alignment: .center)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        ContentView()
//    }
//}
