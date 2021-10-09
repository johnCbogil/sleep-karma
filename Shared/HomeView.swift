//
//  HomeView.swift
//  Shared
//
//  Created by John Bogil on 2/11/21.
//

import SwiftUI

struct ContentView: View {
	@State private var showingDetail = false
	@ObservedObject var viewModel = HomeVM()
	
	var body: some View {
		NavigationView {
			VStack {
                Text("Last 7 nights")
                    .padding()

				Text("\(viewModel.sleepEfficiencyScore)%")
					.font(.largeTitle)

				VStack(alignment: .leading) {
					Text("All sleep logs")
						.font(.title2)
						.foregroundColor(.white)
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
								
				Button("New Log") {
					showingDetail.toggle()
				}
				.sheet(isPresented: $showingDetail) {
					DetailView(userSettings: viewModel)
				}
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
				
			}
			.padding()
			.navigationBarTitle("Sleep Efficiency")
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
