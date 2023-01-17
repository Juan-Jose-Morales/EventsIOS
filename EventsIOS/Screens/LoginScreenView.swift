//
//  LoginScreenView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 16/1/23.
//

import SwiftUI

struct LoginScreenView: View{
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    
    var body: some View{
        VStack{
            VStack{
                Image("Event")
                    .fixedSize()
                   
                
                Text("Iniciar sesion")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .padding(.top,35)
                
                TextField("Email", text: self.$email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                    .padding(.top, 25)
            }
            
            HStack (spacing: 15){
                VStack{
                    if self.visible{
                        TextField("Password", text: self.$pass)
                    }else{
                        SecureField("Password", text: self.$pass)
                    }
                    
                }
                Button(action: {
                    
                }) {
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.color)
                }
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 25)
            
            HStack{
                Spacer()
                Button(action: {
                    
                }){
                    Text("Olvidaste tu contraseña?")
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                    
                }
            }
            .padding(.top ,20)
            HStack{
                Spacer()
                
                Button(action: {
                    
                }){
                    Text("Aun no tienes una cuenta? ")
                        .padding(.top, 25)
                        .foregroundColor(.indigo)
                        
                    
                    Text("Registrate")
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                        .padding(.top, 25)
                        
                }
            }
            Button(action: {
                
                
            }){
                Text("Iniciar Sesion")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top,25)
        }
            .padding(.horizontal, 25)
        }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}

