//
//  Created by Emilio Peláez on 1/10/23.
//

import Foundation
import SwiftUI
import ToolKit

public struct AppDetails {
	public let name: String
	public let icon: Image
	public let version: Bundle.Version
	public let author: String
	
	public init(name: String, icon: Image, version: Bundle.Version, author: String) {
		self.name = name
		self.icon = icon
		self.version = version
		self.author = author
	}
	
	public init(bundle: Bundle, icon: Image, author: String) {
		self.init(name: bundle.displayName, icon: icon, version: bundle.version, author: author)
	}
	
	static let example = AppDetails(
		name: "Application",
		icon: Image(""),
		version: .init(numberString: "1.0", buildString: "ABC"),
		author: "Emilio Peláez"
	)
}
