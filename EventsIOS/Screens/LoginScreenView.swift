//
//  LoginScreenView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 16/1/23.


import SwiftUI

struct LoginScreenView: View{
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @State private var shouldShowRegister: Bool = false
    @State private var shouldShowAgenda: Bool = false
    @State private var shouldShowError: Bool = false
    @State var textalert = ""
    var body: some View{
        
        ZStack {
            // Metodo  para llamar a el Background desde los components
            BackgroundColorView()
            VStack{
                VStack{
                    //Funcion creada en components para llamar al logo
                    LogoImageView()
                    //Funcion para crear el titulo creada en components
                    TitleView(title: "Login")
                    //Funcion para llamar a los texfields creada en una funcion
                    textFields()
                }
                
                HStack (spacing: 15){
                    
                    //Funcion en la cual se comprueba si es visible o no la contraseña , si es visible se le pasa un texfiel si no se le pasa un securityfield
                    if self.visible{
                        TextField("Password", text: self.$pass)
                        
                    }else{
                        SecureField("Password", text: self.$pass)
                            .foregroundColor(color)
                    }
                    
                    Button(action: {
                        self.visible.toggle()
                    }) {
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor((self.visible == true) ? Color.purple : Color.secondary)
                    }
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                .padding(.top, 25)
                
                
                .padding(.top ,20)
                //Boton para crear una nueva cuenta en vez de no tenerla
                HStack{
                    Text("Aun no tienes una cuenta? ")
                        .padding(.top, 25)
                        .foregroundColor(.indigo)
                        .padding(.horizontal,15)
                    Spacer()
                    
                    Button(action: {
                        shouldShowRegister = true
                    }){
                        Text("Registrate")
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)
                            .padding(.top, 25)
                            .padding(.horizontal,10)
                        
                    }.background(
                        NavigationLink(destination: RegisterScreenView(), isActive: $shouldShowRegister) {
                            EmptyView()
                        }
                    )
                }
                
                loginButton(title:  "Iniciar sesion")
                
            }
            .padding(.horizontal, 25)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(Text(""))
        
    }
    
    func textFields() -> some View {
        
        TextField("Email", text: self.$email)
            .foregroundColor(color)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 25)
        
        
    }
    
    //funcion para realizar el login pasamos url de api y diccionario con los campos que vamos a pasar a el servidor de la api
    func login(email: String, pass: String) {
        
        
        let url = "https://superapi.netlify.app/api/login"
        
        
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
    }
    
    func onError(error: String) {
        print(error)
        shouldShowError = true
        textalert = "No existe este usuario"
        
        
    }
    
}
struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}

extension LoginScreenView {
    
    
    func loginButton(title: String) -> some View {
        Button {
            if email.isEmpty || pass.isEmpty{
                shouldShowError = true
                textalert = "Fields are empty"
            }else{
                login(email: email, pass: pass)
            }
            
        } label: {
            Text(title)
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
                .padding(.horizontal, 2)
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top,25)
            
        }
        .background(
            NavigationLink(destination: AgendaView(), isActive: $shouldShowAgenda) {
                EmptyView()
            }
        )
        .alert("Error al logearse", isPresented: $shouldShowError, actions: {
            
            Button{
                
            } label: {
                Text("Ok")
            }
        }){
            Text(textalert)
        }
    }
}
