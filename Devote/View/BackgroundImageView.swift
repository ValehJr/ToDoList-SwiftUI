//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Valeh Ismayilov on 16.07.24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
		  .antialiased(true)
		  .resizable()
		  .scaledToFill()
		  .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}
