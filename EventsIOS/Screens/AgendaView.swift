//
//  AgendaView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 24/1/23.
//

import SwiftUI

struct EventResponseModel: Decodable {
    let name: String?
    let date: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case date
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let date = try? values.decodeIfPresent(Int.self, forKey: .date) {
            self.date = date
        } else if let date = try? values.decodeIfPresent(String.self, forKey: .date) {
            self.date = Int(date)
        } else if let _ = try? values.decodeIfPresent(Float.self, forKey: .date) {
            self.date = nil
        } else {
            self.date = try values.decodeIfPresent(Int.self, forKey: .date)
        }
        
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}


struct EventPresentationModel: Identifiable {
    // el id se genera cada vez que se instancia/crea el modelo, es necesario para el ForEach del LazyVStack ya que SwiftUI así lo requiere
    let id = UUID()
    let name: String
    let date: Int
}


struct AgendaView: View {
    @State var dateSelected: Date = Date()
    @State var events: [EventPresentationModel] = []
    @State var shouldShowNewEvent = false
    
    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 20) {
                    Text("Agenda")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 20)
                    
                    // Picker de fecha, tiene una var @State "dateSelected" donde se guardará el valor al pulsar en el calendario
                    DatePicker("", selection: $dateSelected, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .background(Color.white)
                        .cornerRadius(5)
                        .padding(.horizontal, 10)
                }
                .padding(.bottom, 5)
                
                ScrollView {
                    LazyVStack(spacing: 1) {
                        ForEach(events) { event in
                            HStack {
                                let timeInterval = TimeInterval(event.date)
                                let dateConverted = Date(timeIntervalSince1970: timeInterval)
                                
                                Text(event.name)
                                Spacer()
                                Text("\(dateConverted.formatted())")
                            }
                            .padding(.horizontal, 5)
                            .frame(height: 40)
                            .background(Color.white)
                            .padding(.horizontal, 10)
                        }
                    }
                }
                .padding(.bottom, 5)
                
                
            }
        }
        // Extension de View que se utiliza para presentar vistas modales
        .sheet(isPresented: $shouldShowNewEvent, content: {
            NewEventView(shouldShowNewEvent: $shouldShowNewEvent) {
                // Se llamará a getEvents cuando se pulse el botón de crear evento en la pantalla de NewEvents
                getEvents()
            }
        })
        // Boton de la navbar que mostrará la vista de New Event al pulsarse
        .toolbar {
            Button {
                shouldShowNewEvent = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 15))
                
            }
        }
        // Ciclo de vida de la vista, al crearse se hace la petición de eventos
        .onAppear {
            getEvents()
        }
        // Este bloque de código se llamará cada vez que cambiemos la fecha del picker de fecha
        .onChange(of: dateSelected) { _ in
            _ = Int(dateSelected.timeIntervalSince1970)
        }
    }
    
    
    func getEvents() {
        
        //baseUrl + endpoint
        let url = "https://superapi.netlify.app/api/db/eventos"
        
        // petición
        NetworkHelper.shared.requestProvider(url: url, type: .GET) { data, response, error in
            if let error = error {
                onError(error: error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 { // esto daria ok
                    onSuccess(data: data)
                } else { // esto daria error
                    onError(error: error?.localizedDescription ?? "Request Error")
                }
            }
        }
    }
    
    
    func onSuccess(data: Data) {
        do {
            // Convertimos a modelo de Data los datos que nos llegan
            let eventsNotFiltered = try JSONDecoder().decode([EventResponseModel?].self, from: data)
            
            // Recogemos únicamente los que no son nil y además lo convertimos a modelo de vista
            self.events = eventsNotFiltered.compactMap({ eventNotFiltered in
                // Comprobamos que la fecha no sea nil, en caso de serlo devolvera un nil por lo que no se guardará
                guard let date = eventNotFiltered?.date else { return nil }
                // se crea el objecto de vista con el nombre del evento que en caso de que venga nulo le pondremos un nombre por defecto y la fecha que hemos comprobado que NO será nil
                return EventPresentationModel(name: eventNotFiltered?.name ?? "Empty Name", date: date)
            })
        } catch {
            self.onError(error: error.localizedDescription)
        }
        
    }
    
    func onError(error: String) {
        print(error)
    }
}

struct AgendaView_Previews: PreviewProvider {
    static var previews: some View {
        AgendaView()
    }
}
