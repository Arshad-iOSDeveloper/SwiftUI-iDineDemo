//
//  iodineApp.swift
//  iodine
//
//  Created by Arshad Shaik on 01/07/24.
//

import SwiftUI

@main
struct iodineApp: App {
  @StateObject var order = Order()
  
    var body: some Scene {
        WindowGroup {
            MainView()
            .environmentObject(order)
        }
    }
}
