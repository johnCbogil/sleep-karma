//
//  NightRow.swift
//  SleepKarma
//
//  Created by John Bogil on 2/11/21.
//

import SwiftUI

struct NightRow: View {
	var night: Night

	var body: some View {
		HStack {
			Text(verbatim: night.date.toString(format: "EEEE, MMMM d, yyyy"))
			Spacer()
		}.padding()
	}
}

//struct LandmarkRow_Previews: PreviewProvider {
//	static var previews: some View {
//		NightRow(night: Night(name: "test"))
//	.previewLayout(.fixed(width: 300, height: 70))
//	}
//}
