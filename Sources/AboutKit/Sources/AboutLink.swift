//
//  Created by Emilio Peláez on 19/10/23.
//

import SwiftUI

public struct AboutLink: Identifiable {
	public var id: String { title + url.absoluteString + symbol }
	
	public let title: String
	public let url: URL
	public let color: Color
	public let symbol: String
	
	public init(title: String, url: URL, color: Color = .blue, symbol: String = "link") {
		self.title = title
		self.url = url
		self.color = color
		self.symbol = symbol
	}
}
