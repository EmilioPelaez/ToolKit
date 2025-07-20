//
//  Created by Emilio Peláez on 25/8/24.
//

import SwiftUI

public struct BigButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) private var isEnabled
	
	let color: Color
	let preferFlat: Bool
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.extendHorizontally()
			.font(.title2.weight(.medium))
			.foregroundColor(.white)
			.opacity(configuration.isPressed ? 0.75 : 1)
			.paddingMedium()
			.paddingSmall(.vertical)
			.paddingLarge(.horizontal)
			.conditional {
				if #available (iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
					if preferFlat {
						$0.background { background(configuration: configuration) }
					} else {
						$0.glassEffect(.regular.tint(color), in: shape)
					}
				} else {
					$0.background { background(configuration: configuration) }
				}
			}
			.contentShape(shape)
			.contentShape(.hoverEffect, shape)
#if canImport(UIKit) && !os(watchOS)
			.hoverEffect(.lift)
#endif
			.visiblyDisabled(!isEnabled)
			.frame(maxWidth: 400)
	}
	
	var shape: some Shape {
		RoundedRectangle(cornerRadius: .paddingLarge, style: .continuous)
	}
	
	func background(configuration: Configuration) -> some View {
		shape
			.foregroundStyle(color)
			.brightness(configuration.isPressed ? -0.25 : 0)
	}
}

public extension ButtonStyle where Self == BigButtonStyle {
	static func big(_ color: Color, preferFlat: Bool = false) -> BigButtonStyle {
		BigButtonStyle(color: color, preferFlat: preferFlat)
	}
}
