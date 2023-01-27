//
//  NewEventView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 24/1/23.
//

import SwiftUI

struct NewEventView: View {
    @State var newEvent = ""
    @State var dateSelected: Date = Date()
    @State var color = Color.black.opacity(0.7)
    @Binding var shouldShowNewEvent: Bool
    @State var event = ""
    @State private var shouldShowAgenda: Bool = false
    var completion: () -> () = {}
    
    
    var body: some View {
        
        ZStack{
            
            VStack{
                Image("Event")
                    .resizable()
                    .frame(width: 94,height: 94)
                    .padding(.top,10)
                                    
                    
                TitleView(title: "Crear nuevo evento")
                    .padding(.bottom,40)
                
                
                DatePicker("", selection: $dateSelected, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.horizontal, 10)
                    .padding(.bottom,80)
                
            }
            Spacer()
            
            
            Spacer()
            VStack{
                
                TextField("Evento", text: self.$event)
                    .foregroundColor(Color("Color"))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).stroke(self.event != "" ? Color("Color") : self.color,lineWidth: 2))
                    .padding(.top, 75)
            }
            .padding()
            .padding(.top,480)
            
            VStack{
                newEventButton(title: "Confirmar evento")
                    .padding(.top,700)
            }
            
            
        }
        
    }
    func newEvent(event: String, dateSelected: Date) {
        
        let dateConverted = convertDateToInt(date: dateSelected)
        let url = "https://superapi.netlify.app/api/db/eventos"
        
        
        let dictionary: [String: Any] = [
            "name" : event,
            "date" : dateConverted
            
        ]
        
        NetworkHelper.shared.requestProvider(url: url, params: dictionary) { data, response, error in
            if let error = error {
                onError(error: error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    onSuccess()
                } else {
                    onError(error: error?.localizedDescription ?? "Request Error")
                }
            }
        }
        
    }
    func postEvent() {
        let dateConverted = convertDateToInt(date: dateSelected)
    }
    
    // Convertimos de Date a Int
    func convertDateToInt(date: Date) -> Int {
        return Int(date.timeIntervalSince1970)
    }
    
    func onSuccess() {
        //Avisaria a la vista anterior de que ha hecho lo que tenia que hacer
        completion()
        //cerrar esta vista
        shouldShowNewEvent = false
    }
    func onError(error: String) {
        print(error)
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(shouldShowNewEvent: .constant(true))
    }
}

extension NewEventView{
    
    func newEventButton(title: String) -> some View {
        Button {
            
            newEvent(event: event, dateSelected:dateSelected )
        } label: {
            Text(title)
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top,20)
            
        }
        //        .background(
        //            NavigationLink(destination: AgendaView(), isActive: $shouldShowAgenda) {
        //                EmptyView()
        //            }
        //        )
    }
}
