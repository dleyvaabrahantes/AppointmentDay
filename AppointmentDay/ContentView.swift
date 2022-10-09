//
//  ContentView.swift
//  AppointmentDay
//
//  Created by David on 10/7/22.
//

import SwiftUI

struct ContentView: View {
    @State var show: Bool = false
    var body: some View {
        ZStack{
            Home()
            ButtonFloat(show: $show)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ButtonFloat:View {
    @Binding var show: Bool
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button {
                    self.show.toggle()
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
    }
}
