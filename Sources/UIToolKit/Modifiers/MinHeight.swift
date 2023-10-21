//
//  Created by Emilio Peláez on 18/9/23.
//

import SwiftUI

public extension View {
	/***
	 Utilizes the view provided by the closure to establish a minimum height for this view. The view
	 provided by the closure is rendered at 0 opacity
	 */
	func minSize<V: View>(alignment: Alignment = .center, closure: @escaping () -> V) -> some View {
		ZStack(alignment: alignment) {
			closure()
				.opacity(0)
			self
		}
	}
}
