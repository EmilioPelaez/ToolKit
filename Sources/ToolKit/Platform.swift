//
//  Created by Emilio Peláez on 14/10/24.
//

import SwiftUI

public enum Platform {
	case phone
	case pad
	case mac
	case tv
	case watch
	case car
	case vision
	case unknown
	
	public var isiOS: Bool { self == .phone || self == .pad }
	
	public var isSimulator: Bool {
#if targetEnvironment(simulator)
		true
#else
		false
#endif
	}
	
	public static var current: Platform {
#if os(iOS)
		switch UIDevice.current.userInterfaceIdiom {
		case .phone: return .phone
		case .pad: return .pad
		case .tv: return .tv
		case .carPlay: return .car
		case .mac: return .mac
		case .vision: return .vision
		case _: return .unknown
		}
#elseif os(macOS)
		return .mac
#elseif os(visionOS)
		return .vision
#else
		return .watch
#endif
	}
}
