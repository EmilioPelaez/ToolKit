//
//  Created by Emilio Peláez on 14/10/24.
//

import Foundation

@propertyWrapper
public struct Dirty<Value> {
	
	public private(set) var isDirty: Bool = false
	private var value: Value
	
	public init(wrappedValue: Value) {
		self.value = wrappedValue
	}
	
	public var wrappedValue: Value {
		get { value }
		set {
			value = newValue
			isDirty = true
		}
	}
	
}
