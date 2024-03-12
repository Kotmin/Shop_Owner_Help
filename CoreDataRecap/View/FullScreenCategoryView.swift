//
//  FullScreenCategoryView.swift
//  ShopOwnerApp
//
//  Created by Paweł Jan Tłusty on 10/03/2024.
//

import SwiftUI

struct FullScreenCategoryView: View {
    var body: some View {
        VStack{
            
            CategoryControlView(showEditButton: false)
        }.background(Color.lightBlue)
    }
}

#Preview {
    FullScreenCategoryView()
}


extension Color {
    static let lightBlue = Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255)
}
