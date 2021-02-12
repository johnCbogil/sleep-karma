//
//  DetailView.swift
//  SleepKarma
//
//  Created by John Bogil on 2/11/21.
//

import SwiftUI

struct DetailView: View {
	@State var targetSleepTime = Date()
	@State var targetWakeUpTime = Date()
	@State var bedTime = Date()
	@State var fellAsleepTime = Date()
	@State var awakeNightTime = String()
	@State var wakeUpTime = Date()
	@State var outOfBedTime = Date()
	
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var viewModel: ViewModel

	init(userSettings: ViewModel) {
		self.viewModel = userSettings
	}

	var body: some View {
		NavigationView {
			VStack {
				Spacer()

				DatePicker(
					"Target sleep time",
					selection: $targetSleepTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"Target wake up time",
					selection: $targetWakeUpTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"When you went to bed",
					selection: $bedTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"When you fell asleep",
					selection: $fellAsleepTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
//				DatePicker(
//					"How long you spent awake in the middle of the night",
//					selection: $awakeNightTime,
//					displayedComponents: [.hourAndMinute]
//				)
				TextField("Amount", text: $awakeNightTime)
					.keyboardType(.decimalPad)
					.padding()
				.padding()
				DatePicker(
					"When you woke up",
					selection: $wakeUpTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				DatePicker(
					"When you got out of bed",
					selection: $outOfBedTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
				
				Spacer()
				
				Button("Save log") {

					createNight()
						
					presentationMode.wrappedValue.dismiss()
				}
			}
			.navigationBarTitle("Add new log 📖")
		}
	}
	
	private func createNight() {
		let night = Night(
			targetSleepTime: targetSleepTime,
			targetWakeUpTime: targetWakeUpTime,
			bedTime: bedTime,
			fellAsleepTime: fellAsleepTime,
			awakeNightTime: awakeNightTime,
			wakeUpTime: wakeUpTime,
			outOfBedTime: outOfBedTime)
		
		var oldNights = viewModel.nights
		oldNights.append(night)
		viewModel.nights = oldNights
	}
}

//struct DetailView_Previews: PreviewProvider {
//	static var previews: some View {
//		DetailView()
//	}
//}
