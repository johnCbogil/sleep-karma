//
//  RootView.swift
//  Shared
//
//  Created by John Bogil on 2/11/21.
//

import SwiftUI

struct ContentView: View {
	@State private var showingDetail = false
	@ObservedObject var viewModel = ViewModel()
	
	var body: some View {
		NavigationView {
			VStack {
				Text("\(viewModel.sleepEfficiencyScore)%")
					.font(.largeTitle)
				
				Text("Sleep efficiency for last 7 nights")
					.padding()
				
				Spacer()
				
				VStack(alignment: .leading) {
					Text("Sleep Logs")
						.font(.title2)
						.foregroundColor(.primary)
						.padding(10)

					List {
						ForEach(viewModel.nights.reversed(), id: \.self) { night in
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
					DetailView(userSettings: viewModel)
				}
				
			}
			.padding()
			.navigationBarTitle("Sleep Karma ✨")			
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
	
	func delete(at offsets: IndexSet) {
		var oldNights = viewModel.nights
		oldNights.remove(atOffsets: offsets)
		viewModel.nights = oldNights
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
