//
//  Created by Emilio Peláez on 29/10/23.
//

import SwiftUI
import WidgetKit

public extension View {
	@ViewBuilder
	func widgetBackground(alignment: Alignment, _ backgroundContent: () -> some View) -> some View {
		if #available(iOSApplicationExtension 17.0, iOS 17.0, *) {
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
