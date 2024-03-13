//
//  DetailedProductView.swift
//  Shop_Owner_App
//
//  Created by Paweł Jan Tłusty on 12/03/2024.
//

import SwiftUI

//struct DetailedProductView: View {
//    let product: Product
//    @State var modifyPermission = true // just for Debugging
//    
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        VStack {
//            Text(product.name ?? "Unnamed Product")
//            
//            if let imageName = product.image, let image = UIImage(named: imageName) {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            }
//
//            if modifyPermission {
//                HStack {
//                    Button("Edit") {
//                        // Logic to edit
//                    }
//                    .foregroundColor(.white)
//                    .background(Color.black)
//                    .clipShape(Rectangle())
//
//                    Button("Delete") {
//                        // Logic to delete
//                    }
//                    .foregroundColor(.white)
//                    .background(Color.red)
//                    .clipShape(Rectangle())
//                }
//            }
//
//            Button("Return") {
//                dismiss()
//            }
//        }
//    }
//}



struct DetailedProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var product: Product
    @Binding var isPresented: Bool
    var modifyPermission: Bool = true

    var body: some View {
        VStack {
            Text(product.name ?? "Unnamed Product")
                .font(.title)
            
            if let imageName = product.image, let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else {
                Image("placeholder_image") // Assuming a placeholder image exists
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }

            if modifyPermission {
                HStack {
                    Button("Edit") {
                        // Handle edit action
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(Capsule())

                    Button("Delete") {
                        deleteProduct(product)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .clipShape(Capsule())
                }
            }
            
            Button("Return") {
                isPresented = false
            }
            .padding()
        }
        .padding()
    }
    
    private func deleteProduct(_ product: Product) {
        viewContext.delete(product)
        try? viewContext.save()
    }
}

//
//#Preview {
//    DetailedProductView()
//}
