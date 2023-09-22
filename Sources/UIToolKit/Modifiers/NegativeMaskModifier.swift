//
//  Created by Emilio Peláez on 29/3/23.
//

import SwiftUI

public extension View {
	func negativeMask<Mask: View>(alignment: Alignment = .center, mask: @escaping () -> Mask) -> some View {
		modifier(NegativeMaskModifier(alignment: alignment, mask: mask))
	}
}

struct NegativeMaskModifier<Mask: View>: ViewModifier {
	let alignment: Alignment
	let mask: () -> Mask
	
	init(alignment: Alignment, mask: @escaping () -> Mask) {
		self.alignment = alignment
		self.mask = mask
	}
	
	func body(content: Content) -> some View {
		let mask = mask()
		return content
			.mask {
				ZStack(alignment: alignment) {
					Color.white
					mask
						.opacity(0)
						.overlay {
							Color.black.mask {
								mask
							}
						}
				}
				.compositingGroup()
				.luminanceToAlpha()
			}
	}
}
