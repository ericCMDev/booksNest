//
//  DismissView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 10/4/22.
//

import SwiftUI

struct DismissView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack{
            Spacer()
            Button("Cancelar"){
                
                dismiss()
                
            }
            .tint(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.leading, 12)
            
        }
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
