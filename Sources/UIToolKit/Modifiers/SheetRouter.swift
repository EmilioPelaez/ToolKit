//
//  Created by Emilio Peláez on 1/10/23.
//

import HierarchyResponder
import SwiftUI

public extension View {
	func sheetRouter<V: View, E: Event>(_ event: E.Type, content: @escaping () -> V) -> some View {
		modifier(SheetRouter(eventType: event, screen: content))
	}
}

struct SheetRouter<V: View, E: Event>: ViewModifier {
	@State var presented = false
	
	let eventType: E.Type
	let screen: () -> V
	
	func body(content: Content) -> some View {
		content
			.handleEvent(eventType) { presented = true }
			.sheet(isPresented: $presented, content: screen)
	}
}
