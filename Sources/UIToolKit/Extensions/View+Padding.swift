//
//  Created by Emilio Peláez on 7/2/22.
//

import SwiftUI

public extension View {
	
	func paddingTiny(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingTiny)
	}
	
	func paddingSmall(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingSmall)
	}
	
	func paddingMedium(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingMedium)
	}
	
	func paddingLarge(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingLarge)
	}
	
	func paddingExtra(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingExtra)
	}
	
}
