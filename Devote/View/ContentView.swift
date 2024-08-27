//
//  ContentView.swift
//  Devote
//
//  Created by Valeh Ismayilov on 12.06.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
   //MARK: Property
   @State var task:String = ""
   @State private var showNewTask:Bool = false
   @AppStorage("isDarkMode") private var isDarkMode: Bool = false

   //MARK: Fetching Data
   @Environment(\.managedObjectContext) private var viewContext

   @FetchRequest(
	  sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
	  animation: .default)
   private var items: FetchedResults<Item>

   //MARK: Functions
   private func deleteItems(offsets: IndexSet) {
	  withAnimation {
		 offsets.map { items[$0] }.forEach(viewContext.delete)

		 do {
			try viewContext.save()
		 } catch {

			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		 }
	  }
   }


   //MARK: Body
   var body: some View {
	  NavigationStack {
		 ZStack {
			//MARK: MainView

			VStack {

			   HStack(spacing:10) {
				  Text("Devote")
					 .font(.system(.largeTitle,design: .rounded))
					 .fontWeight(.heavy)
					 .padding(.leading,4)

				  Spacer()
				  EditButton()
					 .font(.system(size: 16,weight: .semibold,design: .rounded))
					 .padding(.horizontal,10)
					 .frame(minWidth: 70,minHeight: 24)
					 .background(
						Capsule().stroke(Color.white,lineWidth: 2)
					 )

				  Button(action: {
					 isDarkMode.toggle()
					 playSound(sound: "sound-tap", type: "mp3")
					 feedback.notificationOccurred(.success)
				  }, label: {
					 Image(systemName: isDarkMode ?  "moon.circle.fill" : "moon.circle")
						.resizable()

						.frame(width: 24,height: 24)
						.font(.system(.title,design: .rounded))
				  })
			   }
			   .padding()
			   .foregroundStyle(.white)

			   Spacer(minLength: 80)

			   Button(action: {
				  showNewTask = true
				  playSound(sound: "sound-ding", type: "mp3")
				  feedback.notificationOccurred(.success)
			   }, label: {
				  Image(systemName: "plus.circle")
					 .font(.system(size: 30,weight: .semibold,design: .rounded))
				  Text("New Task")
					 .font(.system(size: 24,weight: .bold,design: .rounded))
			   })
			   .foregroundStyle(.white)
			   .padding(.horizontal,20)
			   .padding(.vertical,15)
			   .background(
				  LinearGradient(colors: [.pink,.blue], startPoint: .leading, endPoint: .trailing)
					 .clipShape(Capsule()))
			   .shadow(color: Color(red: 0, green: 0, blue: 0,opacity: 0.25), radius: 8,x: 0.0,y: 4.0)
			   List {
				  ForEach(items) { item in
					 ListRowItemView(item: item)		
				  }
				  .onDelete(perform: { indexSet in
					 deleteItems(offsets: indexSet)
				  })
			   }//:List
			   .listStyle(InsetGroupedListStyle())
			   .shadow(color: Color(red: 0, green: 0, blue: 0,opacity: 0.3), radius: 12)
			   .padding(.vertical,0)
			   .frame(maxWidth: 640)
			   .scrollContentBackground(.hidden)


			}//:Vstaks
			.blur(radius: showNewTask ? 8.0 : 0, opaque: false)
			.transition(.move(edge: .bottom))
			.animation(.easeOut(duration: 0.5))
			if showNewTask {
			   BlankView(
				  backgroundColor: isDarkMode ? Color.black : Color.gray,
				  backgroundOpacity: isDarkMode ? 0.3 : 0.5)
				  .onTapGesture {
					 withAnimation {
						showNewTask = false
					 }
				  }
			   NewTaskItemView(isShowing: $showNewTask)
			}
		 }//Zstack
		 .onAppear() {
			UITableView.appearance().backgroundColor = .clear
		 }
		 .navigationTitle("Daily Tasks")
		 .navigationBarTitleDisplayMode(.large)
		 .toolbar(.hidden)

		 .background(
			BackgroundImageView())
		 .background(
			backgroundGradient.ignoresSafeArea(.all)
		 )
	  }//Navigation
	  .preferredColorScheme(isDarkMode ? .dark : .light)
   }
}

#Preview {
   ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
