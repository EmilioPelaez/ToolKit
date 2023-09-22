//
//  Created by Emilio Peláez on 18/9/23.
//

import SwiftUI

public extension Color {
	init?(hex: String) {
		let hex = hex
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.replacingOccurrences(of: "#", with: "")
			.replacingOccurrences(of: "0x", with: "")
			.uppercased()
		
		var rgb: UInt64 = 0
		
		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 1.0
		
		let length = hex.count
		
		guard Scanner(string: hex).scanHexInt64(&rgb) else { return nil }
		
		if length == 6 {
			r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
			g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
			b = CGFloat(rgb & 0x0000FF) / 255.0
			
		} else if length == 8 {
			r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
			g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
			b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
			a = CGFloat(rgb & 0x000000FF) / 255.0
			
		} else {
			return nil
		}
		
		self.init(red: r, green: g, blue: b, opacity: a)
	}
}

