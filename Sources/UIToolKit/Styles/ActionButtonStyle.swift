//
//  Created by Emilio Peláez on 7/2/22.
//

import SwiftUI

public struct ActionButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) private var isEnabled
	
	let color: Color
	let preferFlat: Bool
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.headline)
			.foregroundColor(.white)
			.opacity(configuration.isPressed ? 0.75 : 1)
			.paddingMedium()
			.paddingLarge(.horizontal)
			.conditional {
				if #available (iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
#if os(visionOS)
					$0.background { background(configuration: configuration) }
#else
					if preferFlat {
						$0.background { background(configuration: configuration) }
					} else {
						$0.glassEffect(.regular.tint(color), in: shape)
					}
#endif
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
	}
	
	var shape: some Shape {
		RoundedRectangle(cornerRadius: .paddingMedium, style: .continuous)
	}
	
	func background(configuration: Configuration) -> some View {
		shape
			.foregroundStyle(color)
			.brightness(configuration.isPressed ? -0.25 : 0)
	}
}

public extension ButtonStyle where Self == ActionButtonStyle {
	static func action(_ color: Color, preferFlat: Bool = false) -> ActionButtonStyle {
		ActionButtonStyle(color: color, preferFlat: preferFlat)
	}
}
