//
//  Created by Emilio Peláez on 29/1/23.
//

import SwiftUI

@available(watchOS 10.0, *)
public struct OverlayButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) private var isEnabled
	
	let color: Color
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.title2)
			.paddingMedium()
			.foregroundStyle(color)
			.opacity(configuration.isPressed ? 0.5 : 1)
			.background {
				RoundedRectangle(cornerRadius: .paddingMedium, style: .continuous)
					.foregroundStyle(.regularMaterial)
			}
			.visiblyDisabled(!isEnabled)
	}
}

@available(watchOS 10.0, *)
public extension ButtonStyle where Self == OverlayButtonStyle {
	static func overlay(_ color: Color) -> OverlayButtonStyle {
		OverlayButtonStyle(color: color)
	}
}
