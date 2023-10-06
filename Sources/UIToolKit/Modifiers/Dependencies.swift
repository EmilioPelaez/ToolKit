//
//  Created by Emilio Peláez on 06/10/23.
//

import SwiftUI

public protocol HierarchyDependency {
	associatedtype Key: EnvironmentKey where Key.Value == Bool
	static var path: WritableKeyPath<EnvironmentValues, Bool> { get }
	static var requirement: DependencyRequirement { get }
}

public extension HierarchyDependency {
	var requirement: DependencyRequirement { .strict }
}

public enum DependencyRequirement {
	/**
	 Strict dependency requirement will cause a fatal error if a dependency is not installed when building
	 for Debug. On Release it will fail silently.
	 */
	case strict
	/**
	 Relaxed dependency requirement will print a warning to the console when the dependency is not
	 installed and building for debug.
	 */
	case relaxed
}

public extension View {
	func requires<D: HierarchyDependency>(_ dependency: D.Type) -> some View {
		modifier(HierarchyDependencyRequirement(dependency: dependency))
	}
	
	func installs<D: HierarchyDependency>(_ dependency: D.Type) -> some View {
		environment(dependency.path, true)
	}
}

struct HierarchyDependencyRequirement<D: HierarchyDependency>: ViewModifier {
	let dependency: D.Type
	
	func body(content: Content) -> some View {
		content
			.transformEnvironment(dependency.path) { value in
				guard !value else { return }
				switch dependency.requirement {
				case .strict:
#if DEBUG
					fatalError("WARNING: Dependency \(String(describing: dependency)) not installed")
#endif
				case .relaxed:
#if DEBUG
					print("WARNING: Dependency \(String(describing: dependency)) not installed")
#endif
				}
			}
	}
}
