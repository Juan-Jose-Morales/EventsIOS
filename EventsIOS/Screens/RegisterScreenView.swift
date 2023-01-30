//
//  RegisterScreenView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 16/1/23.


import SwiftUI

struct RegisterScreenView: View{
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var name = ""
    @State var pass = ""
    @State var pass2 = ""
    @State var visible = false
    @State private var shouldShowLogin: Bool = false
    @State private var shouldShowAgenda: Bool = false
    @State private var shouldShowError: Bool = false
    @State var textalert = ""
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>
    
    var body: some View{
        
        VStack{
            
            VStack{
                //Funcion creada en components para llamar al logo
                LogoImageView()
                
                //Funcion para crear el titulo creada en components
                TitleView(title: "Registro")
                //Funcion para llamar a los texfields creada en una funcion
                textFields()
                HStack{
                    Spacer()
                    //Boton para redirijir a iniciar sesion
                    Button(action: {
                        shouldShowLogin = true
                    }){
                        Text("Ya tienes una cuenta? ")
                            .padding(.top, 25)
                            .foregroundColor(.indigo)
                        
                        
                        Text("Inicia Sesion")
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)
                            .padding(.top, 25)
                        
                    }.background(
                        NavigationLink(destination: LoginScreenView(), isActive: $shouldShowLogin) {
                            EmptyView()
                        }
                    )
                }
                RegisterButton(title: "Crear cuenta")
            }
            
            .padding(.horizontal, 25)
        }
        //con estas lineas de codigo se oculta las flechas de navegacion que vienen incluidas con el Navigation link
        .navigationBarBackButtonHidden(true)
        .navigationTitle(Text(""))
    }
    //Funcion para crear los texfield
    func textFields() -> some View {
        VStack{
            TextField("Nombre", text: self.$name)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).stroke(self.name != "" ? Color("Color") : self.color,lineWidth: 2))
                .padding(.top, 10)
            TextField("Email", text: self.$email)
                .foregroundColor(color)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                .padding(.top, 25)
            
            SecureField("Password", text: self.$pass)
                .padding()
            
                .background(RoundedRectangle(cornerRadius: 20).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                .padding(.top, 20)
            
            SecureField(" Repeat Password", text: self.$pass2)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                .padding(.top, 20)
        }
    }
    //Funcion en la cual le paso el email y el pass como string junto con la url de destino de la api para crear un usuario en la base de datos de la API
    private func register(email: String, pass: String) {
        
        
        let url = "https://superapi.netlify.app/api/register"
        
        
        let dictionary: [String: Any] = [
            "user" : email,
            "pass" : pass
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
    
    func onSuccess() {
        shouldShowAgenda = true
        mode.wrappedValue.dismiss()
    }
    
    func onError(error: String) {
        print(error)
        shouldShowError = true
        textalert = "Error al crear nuevo usuario"

    }
}

extension RegisterScreenView{
    // Boton para registrarte en el cual se rcoje el email y la contraseña y se envia a la pantalla de agenda que es la home
    
    func RegisterButton(title: String) -> some View {
        Button {
            if email.isEmpty || pass.isEmpty || pass2.isEmpty || name.isEmpty{
                shouldShowError = true
                textalert = "Rellena todos los campos"
                
            } else if pass != pass2{
                
                shouldShowError = true
                textalert = "Las contraseñas deben coincidir"
            }
            
            else{
                register(email: email, pass: pass)
            }
            
        } label: {
            Text(title)
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top,20)
            
        }
        //realizamos la navegacion hacia el destino que queremos y le pasamos la comprobacion creada en la aprte superior
        .background(
            NavigationLink(destination: AgendaView(), isActive: $shouldShowAgenda) {
                EmptyView()
            }
        )
        .alert("Error al registrarte", isPresented: $shouldShowError, actions: {
            
            Button{
                
            } label: {
                Text("Ok")
            }
        }){
            Text(textalert)
        }
    }
}


struct RegisterScreenView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreenView()
    }
}

