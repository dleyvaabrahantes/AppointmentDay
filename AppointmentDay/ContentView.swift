//
//  ContentView.swift
//  AppointmentDay
//
//  Created by David on 10/7/22.
//

import SwiftUI

struct ContentView: View {
    @State  var currenttab: Tabs = .home
    @Namespace var animation
    
    @State var currentXValue: CGFloat = 0
    
    var body: some View {
        TabView(selection: $currenttab) {
            Home()
                .tag(Tabs.home)
            Text("Find")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tabs.search)
            Text("Setting")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tabs.setting)
        }
        .overlay(
            HStack(spacing: 0){
                ForEach(Tabs.allCases, id: \.rawValue){tab in
                    TabButton(tab: tab)
                    
                }
            }
                .padding(.vertical)
                .padding(.bottom,getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom - 10))
                .background(
                    Color.black
                        .clipShape(BottomCurve(currentValue: currentXValue))
                )
            ,alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
   //     .preferredColorScheme(.white)
    }
    
    @ViewBuilder
    func TabButton(tab: Tabs) -> some View{
        GeometryReader { proxy in
            
            Button {
                withAnimation(.spring()){
                    currenttab = tab
                    currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                Image(systemName: tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(currenttab == tab ? 15 : 0)
                    .background(
                        ZStack{
                            if currenttab == tab {
                                MaterialEffect(style: .systemChromeMaterialDark)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y: currenttab == tab ? -50 : 0)
            }
            .onAppear{
                if tab == Tabs.allCases.first && currentXValue == 0 {
                    currentXValue = proxy.frame(in: .global).midX
                }
            }
        }
        .frame(height: 30)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ButtonFloat:View {
    @Binding var show: Bool
    @Binding var showSheet: Bool
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button {
                    self.show.toggle()
                    self.showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 15)
                        .padding(22)
                    
                }
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotationEffect(.init(degrees: show ? 180 : 0))

            }
            .animation(.spring())
        }
        .padding(.bottom,getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom - 10))
    }
}

enum Tabs: String, CaseIterable {
    case home = "house.fill"
    case search = "magnifyingglass"
    case setting = "gearshape"
}
