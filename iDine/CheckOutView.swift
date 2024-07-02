//
//  CheckOutView.swift
//  iDine
//
//  Created by Arshad Shaik on 01/07/24.
//

import SwiftUI

struct CheckOutView: View {
  @EnvironmentObject var order: Order
  
  let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
  @State private var paymentType = "Cash"
  @State private var addLoyaltyDetails = false
  @State private var loyaltyNumber = ""
  
  let tipAmounts = [10, 15, 20, 25, 0]
  @State private var tipAmount = 15
  
  var totalPrice: String {
    let total = Double(order.total)
    let tipValue = total / 100 * Double(tipAmount)
    return (total + tipValue).formatted(.currency(code: "INR"))
  }
  
  @State private var showPaymentAlert = false
  
  var body: some View {
    Form {
      Section {
        Picker("How do you want to make a payment", selection: $paymentType) {
          ForEach(paymentTypes, id: \.self) {
            Text($0)
          }
        }
        
        Toggle("Add iDine loyalty Card", isOn: $addLoyaltyDetails.animation())
        if addLoyaltyDetails {
          TextField("Enter your iDine Id", text: $loyaltyNumber)
        }
      }
      
      Section("Add a tip?") {
        Picker("Percentage:", selection: $tipAmount) {
          ForEach(tipAmounts, id: \.self) {
            Text("\($0)%")
          }
        }
        .pickerStyle(.segmented)
      }
      
      Section("Total: \(totalPrice)") {
        Button("Confirm Order") {
          showPaymentAlert.toggle()
        }
      }
    }
    .navigationTitle("Payment")
    .navigationBarTitleDisplayMode(.inline)
    .alert("Order Confirmed", isPresented: $showPaymentAlert) {
      // Do actions
    } message: {
      Text("Your total was: \(totalPrice)")
    }
  }
}

#Preview {
  CheckOutView()
    .environmentObject(Order())
}
