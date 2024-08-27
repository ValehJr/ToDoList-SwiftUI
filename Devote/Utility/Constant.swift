//
//  Constant.swift
//  Devote
//
//  Created by Valeh Ismayilov on 02.07.24.
//

import Foundation
import SwiftUI

//MARK: Formarter
let itemFormatter: DateFormatter = {
   let formatter = DateFormatter()
   formatter.dateStyle = .short
   formatter.timeStyle = .medium
   return formatter
}()

//MARK: UI

var backgroundGradient:LinearGradient {
   return LinearGradient(gradient: Gradient(colors: [Color.pink,Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

//MARK: UX

let feedback = UINotificationFeedbackGenerator()
