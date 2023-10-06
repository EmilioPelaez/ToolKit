//
//  ContentView.swift
//  Example
//
//  Created by Emilio Peláez on 06/10/23.
//

import SwiftUI
import UIToolKit

struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
			.requires(MyDependency.self)
	}
}

#Preview {
	ContentView()
}

struct MyDependency: HierarchyDependency {
	struct Key: EnvironmentKey {
		static var defaultValue = false
	}
	
	static var path: WritableKeyPath<EnvironmentValues, Bool> {
		\.myDependency
	}
	
	static var requirement: DependencyRequirement { .strict }
}

extension EnvironmentValues {
	var myDependency: Bool {
		get { self[MyDependency.Key.self] }
		set { self[MyDependency.Key.self] = newValue }
	}
}
