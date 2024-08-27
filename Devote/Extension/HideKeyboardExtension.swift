//
//  HideKeyboardExtendion.swift
//  Devote
//
//  Created by Valeh Ismayilov on 04.07.24.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
   func hideKeyboard() {
	  UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
}
#endif
