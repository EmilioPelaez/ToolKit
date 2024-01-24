//
//  Created by Emilio Peláez on 29/1/23.
//

import SwiftUI

public extension View {
	@ViewBuilder
	func `if`<V: View>(_ condition: Bool, _ ifBuilder: (Self) -> V) -> some View {
		if condition {
			ifBuilder(self)
		} else {
			self
		}
	}
	
	@ViewBuilder
	func `if`<I: View, E: View>(_ condition: Bool, _ ifBuilder: (Self) -> I, else elseBuilder: (Self) -> E) -> some View {
		if condition {
			ifBuilder(self)
		} else {
			elseBuilder(self)
		}
	}
	
	@ViewBuilder
	func ifLet<V: View, T>(_ value: T?, _ ifBuilder: (Self, T) -> V) -> some View {
		if let value {
			ifBuilder(self, value)
		} else {
			self
		}
	}
	
	@ViewBuilder
	func ifLet<I: View, E: View, T>(_ value: T?, _ ifBuilder: (Self, T) -> I, _ elseBuilder: (Self) -> E) -> some View {
		if let value {
			ifBuilder(self, value)
		} else {
			elseBuilder(self)
		}
	}
}
