//
//  DetailView.swift
//  SleepKarma
//
//  Created by John Bogil on 2/11/21.
//

import SwiftUI

struct DetailView: View {
	@State private var date = Date()
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var userSettings: UserSettings

	init(userSettings: UserSettings) {
		self.userSettings = userSettings
	}

	var body: some View {
		NavigationView {
			VStack {
				Spacer()

				DatePicker(
					"Target sleep time",
					selection: $date,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"Target wake up time",
					selection: $date,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"When you went to bed",
					selection: $date,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"When you fell asleep",
					selection: $date,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"How long you spent awake in the middle of the night",
					selection: $date,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"When you woke up",
					selection: $date,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"When you got out of bed",
					selection: $date,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				
				Spacer()
				
				Button("Save log") {
					
					let newLog = Night(name: "bless123")
					var oldLogs = userSettings.nights
					oldLogs.append(newLog)
					userSettings.nights = oldLogs
					
					presentationMode.wrappedValue.dismiss()
				}
			}
			.navigationBarTitle("Add new log 📖")
		}
	}
}

//struct DetailView_Previews: PreviewProvider {
//	static var previews: some View {
//		DetailView()
//	}
//}
