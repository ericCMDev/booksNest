//
//  CardsHomeView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 16/4/22.
//

import SwiftUI

struct CardsHomeView: View {
    var imageName: String
    var imageColor: Color
    var name: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(imageColor)
                .padding()
             
                
            
            HStack {
                VStack(){
                   
                    Text(name)
                        .font(.title2)
                        
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .padding()
                        
                    
                }
                .layoutPriority(10)
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                Spacer()
            }
        }
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(red: 130/255, green: 130/255, blue: 130/255, opacity: 0.2), lineWidth: 2))
        .frame(width: 150, height: 160)
        .padding(.horizontal) //fem padding de la targeta amb un array (padding doble en aquest cas només en té de manera horitzontal i per dalt, però no a baix)
    }
}

struct CardsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CardsHomeView(imageName: "books.vertical.fill", imageColor: .orange, name: "Biblioteca")
    }
}
