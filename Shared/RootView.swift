//
//  RootView.swift
//  Shared
//
//  Created by John Bogil on 2/11/21.
//

import SwiftUI

struct ContentView: View {
	@State private var showingDetail = false
	@ObservedObject var userSettings = UserSettings()
	
	var body: some View {
		NavigationView {
			VStack {
				Text("85%")
					.font(.largeTitle)
				
				Text("Sleep efficiency for last 7 nights")
					.padding()
				
				Spacer()
				
				VStack(alignment: .leading) {
					Text("Logs")
						.font(.title)
						.foregroundColor(.primary)
						.padding()

					List {
						ForEach(userSettings.nights, id: \.self) { night in
							NightRow(night: night)
						}
						.onDelete(perform: delete)
					}
				}
				.background(Color.blue)
				.padding()
								
				Button("Add log") {
					showingDetail.toggle()
				}
				.sheet(isPresented: $showingDetail) {
					DetailView(userSettings: userSettings)
				}
				
			}
			.padding()
			.navigationBarTitle("Sleep Karma ✨")			
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
	
	func delete(at offsets: IndexSet) {
		userSettings.nights.remove(atOffsets: offsets)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
