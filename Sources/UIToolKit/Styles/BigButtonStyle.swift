//
//  Created by Emilio Peláez on 25/8/24.
//

import SwiftUI

public struct BigButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) private var isEnabled
	
	let color: Color
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.extendHorizontally()
			.font(.title2)
			.fontWeight(.medium)
			.foregroundColor(.white)
			.opacity(configuration.isPressed ? 0.75 : 1)
			.paddingMedium()
			.paddingSmall(.vertical)
			.paddingLarge(.horizontal)
			.background {
				color
					.brightness(configuration.isPressed ? -0.25 : 0)
			}
			.cornerRadius(.paddingLarge)
#if canImport(UIKit) && !os(watchOS)
			.hoverEffect(.lift)
#endif
			.visiblyDisabled(!isEnabled)
			.frame(maxWidth: 400)
	}
}

public extension ButtonStyle where Self == BigButtonStyle {
	static func big(_ color: Color) -> BigButtonStyle {
		BigButtonStyle(color: color)
	}
}
