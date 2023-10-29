//
//  Created by Emilio Peláez on 29/10/23.
//

import SwiftUI

public extension View {
	@ViewBuilder
	func numericTextTransition(countsDown: Bool = false) -> some View {
		if #available(iOS 17.0, iOSApplicationExtension 17.0, *) {
			contentTransition(.numericText(countsDown: countsDown))
		} else {
			self
		}
	}
}
