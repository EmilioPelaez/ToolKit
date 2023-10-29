//
//  Created by Emilio Peláez on 29/10/23.
//

import SwiftUI
import WidgetKit

public extension WidgetConfiguration {
	func compatibleContentMarginsDisabled() -> some WidgetConfiguration {
		if #available(iOS 17.0, iOSApplicationExtension 17.0, *) {
			return contentMarginsDisabled()
		} else {
			return self
		}
	}
}
