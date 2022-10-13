//
//  appointment.swift
//  AppointmentDay
//
//  Created by David on 10/7/22.
//

import Foundation


struct AppointmentItem: Identifiable {
    var id = UUID().uuidString
    var name: String
    var telf: String 
    var description: String
    var date: Date

}
