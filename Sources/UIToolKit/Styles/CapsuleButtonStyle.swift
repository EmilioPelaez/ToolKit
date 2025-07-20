//
//  Created by Emilio Peláez on 18/12/22.
//

import SwiftUI

public struct CapsuleButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) private var isEnabled
	
	let color: Color
	let preferFlat: Bool
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.foregroundColor(.white)
			.opacity(configuration.isPressed ? 0.75 : 1)
			.font(.headline)
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
						$0.glassEffect(.regular.interactive().tint(color), in: Capsule())
					}
#endif
				} else {
					$0.background { background(configuration: configuration) }
				}
			}
			.contentShape(Capsule())
#if canImport(UIKit) && !os(watchOS)
			.hoverEffect(.lift)
#endif
			.visiblyDisabled(!isEnabled)
	}
	
	func background(configuration: Configuration) -> some View {
		Capsule()
			.foregroundColor(color)
			.brightness(configuration.isPressed ? -0.25 : 0)
	}
}

public extension ButtonStyle where Self == CapsuleButtonStyle {
	static func capsule(_ color: Color, preferFlat: Bool = false) -> CapsuleButtonStyle {
		CapsuleButtonStyle(color: color, preferFlat: preferFlat)
	}
}
