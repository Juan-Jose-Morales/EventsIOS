//
//  ContentView.swift
//  EventsIOS
//
//  Created by Juan jose Morales on 15/1/23.
//

import SwiftUI



struct PrimaryButton: View {
    var title: String
    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("PrimaryColor"))
                .cornerRadius(50)
        }
        
    }
}





