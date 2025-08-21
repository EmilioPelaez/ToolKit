//
//  Created by Emilio Peláez on 29/10/23.
//

import SwiftUI

public extension View {
	@ViewBuilder
	func numericTextTransition(countsDown: Bool = false) -> some View {
		if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, iOSApplicationExtension 16.0, *) {
			contentTransition(.numericText(countsDown: countsDown))
		} else {
			self
		}
	}
}
