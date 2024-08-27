//
//  BlankView.swift
//  Devote
//
//  Created by Valeh Ismayilov on 16.07.24.
//

import SwiftUI

struct BlankView: View {
   var backgroundColor:Color
   var backgroundOpacity:Double

    var body: some View {
	   VStack {
		  Spacer()
	   }
	   .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
	   .background(backgroundColor)
	   .opacity(backgroundOpacity)
	   .blendMode(.overlay)
	   .ignoresSafeArea(edges: .all)
    }
}

#Preview {
   BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
	  .background(BackgroundImageView())
	  .background(backgroundGradient.ignoresSafeArea(.all))
}
