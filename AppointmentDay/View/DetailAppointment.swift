//
//  DetailAppointment.swift
//  AppointmentDay
//
//  Created by David on 10/13/22.
//

import SwiftUI

struct DetailAppointment: View {
    @StateObject var appointmentModel: AppointmentViewModel = AppointmentViewModel()
    // personal
    @State private var name: String = ""
    
    // address
    @State private var Description: String = ""
    @State private var Phone: String = ""
    
    @State private var selectedGenderIndex: Int = 0
    @State private var date = Date()
    
    private var genderOptions = ["🙍‍♂️ Male", "🙍‍♀️ Female", "🤖 Other"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Personal Info")) {
                        TextField("Your name", text: $name)
                        TextField("Your phone", text: $Phone).keyboardType(.numberPad)
                        
                        Picker("Gender", selection: $selectedGenderIndex) {
                            ForEach(0..<genderOptions.count) {
                                Text(self.genderOptions[$0])
                            }
                        }.pickerStyle( SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Details")) {
                        DatePicker(selection: $date, in: Date()...) {
                            Text("Date:")
                        }
                        TextField("Description", text: $Description)
                    }
                    
                    
                }.navigationBarTitle("Deatil Appointment")
                Button {
//                    let appoint = Appointment(context: viewContext)
//                    appoint.id = UUID()
//                    appoint.name = name
//                    appoint.detail = Description
//                    appoint.telf = Phone
//                    appoint.date = date
//                    try? viewContext.save()
//                    print(appointmentList.count)
                } label: {
                    Text("insertar")
                }
                Spacer()
            }
            
        }
    }
    
}

struct DetailAppointment_Previews: PreviewProvider {
    static var previews: some View {
        DetailAppointment()
    }
}
