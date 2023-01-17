//
//  HomeScreenView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 16/1/23.
//

import SwiftUI

struct HomeScreenView: View {
    
    var body: some View {
        ZStack{
            Color("BgColor").edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Spacer()
                Image("Event")
                Spacer()
                PrimaryButton(title: "Empezemos")
                
                Text("Iniciar Sesion")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(50.0)
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0 ,y: 16)
                    .padding(.vertical)
                
                HStack{
                    Text("Eres nuevo en la app?")
                    Text("Registrate ")
                        .foregroundColor(Color("PrimaryColor"))
                }
                
                
            }
            .padding()
        }
    }
}
struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
