//
//  Created by Emilio Peláez on 06/10/23.
//

import SwiftUI

public protocol HierarchyDependency {
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
	func requires(_ dependency: any HierarchyDependency.Type) -> some View {
		transformEnvironment(\.hierarchyDependencies) { dependencies in
			if dependencies.contains(where: { $0 == dependency }) { return }
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
	
	func installs<D: HierarchyDependency>(_ dependency: D.Type, preventDuplicates: Bool = false) -> some View {
		transformEnvironment(\.hierarchyDependencies) { dependencies in
			if preventDuplicates && dependencies.contains(where: { $0 == dependency }) {
				fatalError("Dependency \(String(describing: dependency)) is already installed")
			}
			dependencies.append(dependency)
		}
	}
}

struct HierarchyDependenciesKey: EnvironmentKey {
	static var defaultValue: [any HierarchyDependency.Type] = []
}

extension EnvironmentValues {
	var hierarchyDependencies: [any HierarchyDependency.Type] {
		get { self[HierarchyDependenciesKey.self] }
		set { self[HierarchyDependenciesKey.self] = newValue }
	}
}
