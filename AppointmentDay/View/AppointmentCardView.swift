//
//  AppointmentCardView.swift
//  AppointmentDay
//
//  Created by David on 10/7/22.
//

import SwiftUI

struct AppointmentCardView: View {
    @StateObject var viewModel: AppointmentViewModel = AppointmentViewModel()
    var appointment: AppointmentItem
    var body: some View {
        HStack(alignment: .top, spacing: 30){
            VStack(spacing: 10){
                Circle()
                    .fill(viewModel.isCurrentHour(date: appointment.date) ? .black : .clear)
                    .frame(width: 15, height: 15)
                    .background {
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    }
                    .scaleEffect(!viewModel.isCurrentHour(date: appointment.date) ? 0.8 : 1)
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            VStack{
                HStack(alignment: .top, spacing: 10){
                    VStack(alignment: .leading, spacing: 12) {
                        Text(appointment.name)
                            .font(.title2.bold())
                        Text(appointment.description)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .hLeading()
                    Text(appointment.date.formatted(date: .omitted, time: .shortened))
                }
                if viewModel.isCurrentHour(date: appointment.date){
                    HStack(spacing: 0){
                        HStack(spacing: -10){
                            ForEach(["user1", "user2", "user3"], id: \.self){user in
                                Image(user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .background {
                                        Circle()
                                            .stroke(.white, lineWidth: 5)
                                    }
                            }
                        }
                        .hLeading()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.black)
                                .padding(10)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
                            
                        }

                    }
                    .padding(.top)
                }
            }
            .foregroundColor(viewModel.isCurrentHour(date: appointment.date) ? .white : .black)
            .padding(viewModel.isCurrentHour(date: appointment.date) ? 15 : 0)
            .padding(.bottom, viewModel.isCurrentHour(date: appointment.date) ? 0 : 10)
            .hLeading()
            .background(content: {
                Color(.black)
                    .cornerRadius(25)
                    .opacity(viewModel.isCurrentHour(date: appointment.date) ? 1 : 0)
            })
           
        }
        .hLeading()
    }
        
}

struct AppointmentCardView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentCardView(appointment: AppointmentItem(name: "jose", telf: "1213", description: "Cut and Bar", date: .init(timeIntervalSince1970: 1665155364)))
    }
}
