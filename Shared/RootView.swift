//
//  ContentView.swift
//  Shared
//
//  Created by John Bogil on 2/11/21.
//

import SwiftUI

struct ContentView: View {
	@State private var showingDetail = false
	private let nights = [Night(name: "test123")]
	
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

					List(nights, id: \.name) { night in
						  NightRow(night: night)
					  }
				}
				.background(Color.blue)
				.padding()
								
				Button("Add log") {
					showingDetail.toggle()
				}
				.sheet(isPresented: $showingDetail) {
					DetailView()
				}
				
			}
			.padding()
			.navigationBarTitle("Sleep Karma ✨")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
