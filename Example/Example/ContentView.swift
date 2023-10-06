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
	static var requirement: DependencyRequirement { .relaxed }
}
