//
//  AppoinmentViewModel.swift
//  AppointmentDay
//
//  Created by David on 10/7/22.
//

import Foundation
import SwiftUI


class AppointmentViewModel : ObservableObject {
    @Published var storedAppointment: [Appointment] = [
        Appointment(name: "Pepe", description: "Cut and Bar", date: .init(timeIntervalSince1970: 1665582203)),
        Appointment(name: "Jose", description: "Cut and Bar", date: .init(timeIntervalSince1970: 1665585803)),
        Appointment(name: "Mario", description: "Cut and Bar", date: .init(timeIntervalSince1970: 1665593003)),
        Appointment(name: "Jesus", description: "Cut and Bar", date: .init(timeIntervalSince1970: 1665507098)),
        Appointment(name: "Frrank", description: "Cut and Bar", date: .init(timeIntervalSince1970: 1665174124))
        
    ]
    
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    
    @Published var filteredAppointment: [Appointment]?
    
    init(){
//        if currentWeek.isEmpty{
//            fetchCurrentWeek()
//        }else {
//            fetchCurrentWeek(dateLast: currentWeek.last)
//        }
        fetchCurrentWeek()
        filterTodayAppoint()
    }
    
    func fetchCurrentWeek(dateLast: Date? = Date()){
     //   let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: dateLast ?? Date())
        
        guard let firstWeekDate = week?.start else { return }
        
        (1...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDate){
                currentWeek.append(weekDay)
            }
        }
    }
    
    func extracDate(date: Date, format: String)-> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date)-> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
        
    }
    
    func filterTodayAppoint(){
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            let filtered = self.storedAppointment.filter{
                return calendar.isDate($0.date, inSameDayAs: self.currentDay)
            }
                .sorted { value1, value2 in
                    return value2.date > value1.date
                }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredAppointment = filtered
                }
            }
        }
    }
    
    func isCurrentHour(date: Date)->Bool {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
