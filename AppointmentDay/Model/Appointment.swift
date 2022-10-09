//
//  appointment.swift
//  AppointmentDay
//
//  Created by David on 10/7/22.
//

import Foundation


struct Appointment: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var date: Date

}
