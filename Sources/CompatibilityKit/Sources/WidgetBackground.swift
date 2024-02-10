//
//  Created by Emilio Peláez on 29/10/23.
//

import SwiftUI
import WidgetKit

public extension View {
	@ViewBuilder
	func widgetBackground(alignment: Alignment = .center, backgroundContent: () -> some View = { Color.clear }) -> some View {
		if #available(iOS 17.0, iOSApplicationExtension 17.0, watchOS 10.0, *) {
			containerBackground(for: .widget, alignment: alignment) {
				backgroundContent()
			}
		} else {
			background(alignment: alignment) {
				backgroundContent()
			}
		}
	}
}
