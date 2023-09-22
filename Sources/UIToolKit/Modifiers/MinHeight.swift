//
//  Created by Emilio Peláez on 18/9/23.
//

import SwiftUI

public extension View {
	/***
	 Utilizes the view provided by the closure to establish a minimum height for this view. The view
	 provided by the closure is rendered at 0 opacity
	 */
	func minHeight<V: View>(_ closure: @escaping () -> V) -> some View {
		ZStack {
			closure()
				.opacity(0)
			self
		}
	}
}
