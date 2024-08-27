//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Valeh Ismayilov on 16.07.24.
//

import SwiftUI

struct NewTaskItemView: View {

   @Environment(\.managedObjectContext) private var viewContext
   @State private var task:String = ""
   @Binding var isShowing:Bool
   @AppStorage("isDarkMode") private var isDarkMode: Bool = false

   private var isButtonActive:Bool {
	  task.isEmpty
   }

   //MARK: Functions

   private func addItem() {
	  withAnimation {
		 let newItem = Item(context: viewContext)
		 newItem.timestamp = Date()
		 newItem.task = task
		 newItem.completion = false
		 newItem.id = UUID()

		 do {
			try viewContext.save()
		 } catch {

			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		 }
		 task = ""
		 hideKeyboard()
		 isShowing = false
	  }
   }

   
    var body: some View {
	   VStack {
		  Spacer()
		  VStack(spacing:16,content: {
			 TextField("New Task",text: $task).foregroundStyle(.pink)
				.font(.system(size: 24,weight: .bold,design: .rounded))

				.padding()
				.background(
				  isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
				)
				.clipShape(RoundedRectangle(cornerRadius: 10))

			 Button(action: {
				addItem()
				playSound(sound: "sound-ding", type: "mp3")
				feedback.notificationOccurred(.success)
			 }, label: {
				Spacer()
				Text("Save")
				   .font(.system(size: 24,weight: .bold,design: .rounded))
				Spacer()
			 })
			 .disabled(isButtonActive)
			 .onTapGesture {
				if isButtonActive {
				   playSound(sound: "sound-tap", type: "mp3")
				}
			 }
			 .padding()
			 .foregroundStyle(.white)
			 .background(isButtonActive ? Color.blue : Color.pink)
			 .clipShape(RoundedRectangle(cornerRadius: 10))
		  })//:Vstack
		  .padding(.horizontal)
		  .padding(.vertical,20)
		  .background(
			isDarkMode ?  Color(UIColor.secondarySystemBackground) : Color(.white)
		  )
		  .clipShape(RoundedRectangle(cornerRadius: 16))
		  .shadow(color:Color(red: 0, green: 0, blue: 0,opacity: 0.65),radius: 24)
		  .frame(maxWidth: 640)
	   }
	   .padding()
    }
}

#Preview {
   NewTaskItemView(isShowing: .constant(true))
	  .background(Color.gray.ignoresSafeArea(.all))
}
