//
//  Home.swift
//  AppointmentDay
//
//  Created by David on 10/7/22.
//

import SwiftUI

struct Home: View {
    @StateObject var appointmentModel: AppointmentViewModel = AppointmentViewModel()
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(appointmentModel.currentWeek, id: \.self){ day in
                                VStack(spacing: 10) {
                                    Text(appointmentModel.extracDate(date: day, format: "dd"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    Text(appointmentModel.extracDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width:8, height: 8)
                                        .opacity(appointmentModel.isToday(date: day) ? 1 : 0)
                                }
                                .foregroundStyle(appointmentModel.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(appointmentModel.isToday(date: day) ? .white: .black)
                                .frame(width: 45, height: 90)
                                .background {
                                    ZStack{
                                        if appointmentModel.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                }
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation {
                                        appointmentModel.currentDay = day
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .refreshable {
                        appointmentModel.fetchCurrentWeek(dateLast: appointmentModel.currentWeek.last)
                    }
                    AppointmentView()
                } header: {
                    HeaderView()
                }

            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    func HeaderView()->some View {
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                Text(Date().formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            Button {
                
            } label: {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }

        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
    
    
    func AppointmentView() -> some View {
        LazyVStack(spacing: 25){
            if let appointment = appointmentModel.filteredAppointment{
                if appointment.isEmpty{
                    Text("No appointment")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                }else{
                    ForEach(appointment){ value in
                        AppointmentCardView(appointment: value)
                        
                    }
                    
                }
                    
                
            }else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        .onChange(of: appointmentModel.currentDay) { newValue in
            appointmentModel.filterTodayAppoint()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


extension View {
    func hLeading()-> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing()-> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter()-> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func getSafeArea()-> UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}
