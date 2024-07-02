//
//  OrderView.swift
//  iDine
//
//  Created by Arshad Shaik on 01/07/24.
//

import SwiftUI

struct OrderView: View {
  @EnvironmentObject var order: Order
  
    var body: some View {
      NavigationStack {
        List {
          Section {
            ForEach(order.items) { item in
              HStack {
                Text(item.name)
                Spacer()
                Text("INR \(item.price)")
              }
            }
            .onDelete(perform: { indexSet in
              deleteItem(at: indexSet)
            })
          }
          
          Section {
            NavigationLink("Place Order") {
              CheckOutView()
            }
          }
          .disabled(order.items.isEmpty)
        }
        .navigationTitle("Order")
        .toolbar {
          EditButton()
        }
      }
    }
  
  func deleteItem(at offsets: IndexSet) {
    order.items.remove(atOffsets: offsets)
  }
}

#Preview {
    OrderView()
    .environmentObject(Order())
}
