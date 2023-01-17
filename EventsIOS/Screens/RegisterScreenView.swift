//
//  RegisterScreenView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 16/1/23.
//

import SwiftUI

struct RegisterScreenView: View{
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var name = ""
    @State var pass = ""
    @State var pass2 = ""
    @State var visible = false
    
    var body: some View{
        VStack{
           
            VStack{
                Image("Event")
                    .fixedSize()
                   
                
                Text("Registro")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .padding(.top,20)
                
                TextField("Nombre", text: self.$name)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.name != "" ? Color("Color") : self.color,lineWidth: 2))
                    .padding(.top, 10)
            }
            VStack{
                TextField("Email", text: self.$email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                    .padding(.top, 20)
            }
            
            HStack (spacing: 15){
                VStack{
                    if self.visible{
                        TextField("Password", text: self.$pass)
                    }else{
                        SecureField("Password", text: self.$pass)
                    }
                    
                }
                
            }
            
          
            .padding()
            
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 20)
            
            
            
            HStack (spacing: 15){
                VStack{
                    if self.visible{
                        TextField("Repeat Password", text: self.$pass2)
                    }else{
                        SecureField(" Repeat Password", text: self.$pass2)
                    }
                    
                }
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 20)
            
            HStack{
                Spacer()
                
                Button(action: {
                    
                }){
                    Text("Ya tienes una cuenta? ")
                        .padding(.top, 25)
                        .foregroundColor(.indigo)
                        
                    
                    Text("Inicia Sesion")
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                        .padding(.top, 25)
                        
                }
            }
            Button(action: {
                
                
            }){
                Text("Crear cuenta")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top,20)
        }
            .padding(.horizontal, 25)
        }
}

struct RegisterScreenView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreenView()
    }
}
