//
//  ListRowItemView.swift
//  Devote
//
//  Created by Valeh Ismayilov on 17.07.24.
//

import SwiftUI

struct ListRowItemView: View {
   @Environment(\.managedObjectContext) var viewContext

   @ObservedObject var item: Item
    var body: some View {
	   Toggle(isOn: $item.completion, label: {
		  Text(item.task ?? "")
			 .font(.system(.title2,design: .rounded))
			 .fontWeight(.heavy)
			 .foregroundStyle(item.completion ? .pink : .primary)
			 .padding(.vertical,12)
			 .animation(.default)
	   })
	   .toggleStyle(CheckboxStyle())
	   .onReceive(item.objectWillChange, perform: { _ in
		  if self.viewContext.hasChanges {
			 try? self.viewContext.save()
		  }
	   })
    }
}
