//
//  Created by Emilio Peláez on 19/12/22.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public enum ShakeController: HierarchyDependency {}

@available(iOS 16.0, iOSApplicationExtension 16.0, *)
public extension View {
	func onShakeController() -> some View {
#if canImport(UIKit) && !os(watchOS)
		modifier(OnShakeController())
			.installs(ShakeController.self, preventDuplicates: true)
#else
		self
#endif
	}
	
	func onShake(_ perform: @escaping () -> Void) -> some View {
#if canImport(UIKit) && !os(watchOS)
		modifier(OnShakeObserver(action: perform))
			.requires(ShakeController.self, mode: .relaxed)
#else
		self
#endif
	}
}

#if canImport(UIKit) && !os(watchOS)
struct OnShakeKey: PreferenceKey {
	struct Perform: Equatable {
		let id = UUID()
		
		let closure: () -> Void
		
		func callAsFunction() { closure() }
		
		static func == (lhs: OnShakeKey.Perform, rhs: OnShakeKey.Perform) -> Bool {
			lhs.id == rhs.id
		}
	}
	
	static var defaultValue: Perform?
	
	static func reduce(value: inout Perform?, nextValue: () -> Perform?) {
		let perform1 = value?.closure
		let perform2 = nextValue()
		value = .init {
			perform1?()
			perform2?()
		}
	}
}

@available(iOS 16.0, iOSApplicationExtension 16.0, *)
struct OnShakeController: ViewModifier {
	@State var perform: OnShakeKey.Perform?
	
	func body(content: Content) -> some View {
		content
			.onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
				perform?()
			}
			.onPreferenceChange(OnShakeKey.self) { perform = $0 }
	}
}

struct OnShakeObserver: ViewModifier {
	@State var perform: OnShakeKey.Perform?
	
	let action: () -> Void
	
	func body(content: Content) -> some View {
		content
			.onPreferenceChange(OnShakeKey.self) { perform = $0 }
			.preference(key: OnShakeKey.self, value: perform ?? .init(closure: action))
	}
}

extension UIDevice {
	static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
	override open func motionEnded(_ motion: UIEvent.EventSubtype, with _: UIEvent?) {
		if motion == .motionShake {
			NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
		}
	}
}
#endif
