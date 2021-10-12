//
//  NewLogView.swift
//  SleepKarma
//
//  Created by John Bogil on 2/11/21.
//

import SwiftUI

struct LogDetailView: View {
	@State var targetSleepTime = Date()
	@State var targetWakeUpTime = Date()
	@State var bedTime = Date()
	@State var fellAsleepTime = Date()
	@State var awakeNightTime = "0"
	@State var wakeUpTime = Date()
	@State var outOfBedTime = Date()
	
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var viewModel: LogDetailVM

    init(state: LogDetailVM.State) {
        self.viewModel = LogDetailVM(state: state)
	}

	var body: some View {
		NavigationView {
			VStack {
				DatePicker(
					"Target sleep time",
					selection: $targetSleepTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
                .foregroundColor(.primary)

				DatePicker(
					"Target wake up time",
					selection: $targetWakeUpTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
                .foregroundColor(.primary)

				DatePicker(
					"When you went to bed",
					selection: $bedTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
                .foregroundColor(.primary)

				DatePicker(
					"When you fell asleep",
					selection: $fellAsleepTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
                .foregroundColor(.primary)

				HStack() {
					Text("Time spent awake in middle of night (minutes)")
						.padding()
                        .foregroundColor(.primary)

					TextField("\(awakeNightTime)", text: $awakeNightTime)
						.padding()
                        .foregroundColor(.primary)
						.keyboardType(.decimalPad)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.multilineTextAlignment(.trailing)
						.frame(maxWidth: 100)
				}

				DatePicker(
					"When you woke up",
					selection: $wakeUpTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
                .foregroundColor(.primary)

				DatePicker(
					"When you got out of bed",
					selection: $outOfBedTime,
					displayedComponents: [.hourAndMinute]
				)
				.padding()
                .foregroundColor(.primary)

				Button("Save log") {
					createNight()
					presentationMode.wrappedValue.dismiss()
				}
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
			}
            .padding()
			.navigationBarTitle("📖 Add new log")
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
			outOfBedTime: outOfBedTime
        )

        viewModel.saveLog.send(night)
	}
}

struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
        LogDetailView(state: .create)
.previewInterfaceOrientation(.portraitUpsideDown)
	}
}
