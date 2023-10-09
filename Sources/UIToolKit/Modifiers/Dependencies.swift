//
//  Created by Emilio Peláez on 06/10/23.
//

import SwiftUI

public protocol HierarchyDependency {}

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
	
	public static let `default` = DependencyRequirement.relaxed
}

public extension View {
	func requires(_ dependency: any HierarchyDependency.Type, mode: DependencyRequirement = .default) -> some View {
#if DEBUG
		transformEnvironment(\.hierarchyDependencies) { dependencies in
			if dependencies.contains(where: { $0 == dependency }) { return }
			switch mode {
			case .strict:
				fatalError("WARNING: Dependency \(String(describing: dependency)) not installed")
			case .relaxed:
				print("WARNING: Dependency \(String(describing: dependency)) not installed")
			}
		}
#else
		self
#endif
	}
	
	func installs<D: HierarchyDependency>(_ dependency: D.Type, preventDuplicates: Bool = false) -> some View {
#if DEBUG
		transformEnvironment(\.hierarchyDependencies) { dependencies in
			if preventDuplicates && dependencies.contains(where: { $0 == dependency }) {
				fatalError("Dependency \(String(describing: dependency)) is already installed")
			}
			dependencies.append(dependency)
		}
#else
		self
#endif
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
