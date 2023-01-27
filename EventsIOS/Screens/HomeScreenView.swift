//
//  HomeScreenView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 16/1/23.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var shouldShowLogin: Bool = false
    @State private var shouldShowRegister: Bool = false
    var body: some View {
        NavigationView {
            ZStack{
                BackgroundColorView()
                
                
                VStack {
                    Spacer()
                    LogoImageView()
                    Spacer()
                    PrimaryButton(title: "Empezemos")
                    Button {
                        
                        shouldShowLogin = true
                    } label: {
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
                    }
                    .background(
                        NavigationLink(destination: LoginScreenView(), isActive: $shouldShowLogin) {
                            EmptyView()
                        }
                    )
                    HStack{
                        Text("Eres nuevo en la app?")
                        
                        Button(action: {
                            shouldShowRegister = true
                        }){
                            Text("Registrate")
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryColor"))
                            
                            
                        }.background(
                            NavigationLink(destination: RegisterScreenView(), isActive: $shouldShowRegister) {
                                EmptyView()
                            }
                        )
                    }
                    
                    
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(Text(""))
        }
    }
}
struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
