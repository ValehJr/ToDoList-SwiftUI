//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Valeh Ismayilov on 17.07.24.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {

   func makeBody(configuration: Configuration) -> some View {
	  return HStack {
		 Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
			.foregroundStyle(configuration.isOn ? .pink : .primary)
			.font(.system(size: 30,weight: .semibold,design: .rounded))
			.onTapGesture {
			   configuration.isOn.toggle()
			   feedback.notificationOccurred(.success)
			   if configuration.isOn {
				  playSound(sound: "sound-rise", type: "mp3")
			   } else {
				  playSound(sound: "sound-tap", type: "mp3")
			   }
			}

		 configuration.label
	  }
   }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
   Toggle("Placeholder label",isOn: .constant(true))
	  .toggleStyle(CheckboxStyle())
	  .padding()
}
