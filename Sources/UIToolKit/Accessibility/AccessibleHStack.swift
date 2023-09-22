//
//  AccessibleHStack.swift
//  Views
//
//  Created by Emilio Peláez on 13/11/21.
//

import SwiftUI

public struct AccessibleHStack<Content: View>: View {
	@Environment(\.dynamicTypeSize) var dynamicTypeSize
	
	let triggeringSize: DynamicTypeSize
	let alignment: VerticalAlignment
	let alternativeAlignment: HorizontalAlignment
	let spacing: CGFloat?
	let alternativeSpacing: CGFloat?
	let content: Content
	
	public init(triggeringSize: DynamicTypeSize = .accessibility1,
	            alignment: VerticalAlignment = .center,
	            alternativeAlignment: HorizontalAlignment = .center,
	            spacing: CGFloat? = nil,
	            alternativeSpacing: CGFloat? = nil,
	            @ViewBuilder content: () -> Content) {
		self.triggeringSize = triggeringSize
		self.alignment = alignment
		self.alternativeAlignment = alternativeAlignment
		self.spacing = spacing
		self.alternativeSpacing = alternativeSpacing
		self.content = content()
	}
	
	public var body: some View {
		if dynamicTypeSize >= triggeringSize {
			VStack(alignment: alternativeAlignment, spacing: alternativeSpacing) {
				content
			}
		} else {
			HStack(alignment: alignment, spacing: spacing) {
				content
			}
		}
	}
}

struct AccessibleHStack_Previews: PreviewProvider {
	static var previews: some View {
		AccessibleHStack {
			Image(systemName: "folder.fill")
			Text("Folder")
		}
	}
}
